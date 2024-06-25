package com.goods.g1.controller;

import com.goods.g1.dto.KakaoProfile;
import com.goods.g1.dto.MemberVO;
import com.goods.g1.dto.OAuthToken;
import com.goods.g1.service.MemberService;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@Controller
public class MemberController {
    @Autowired
    MemberService ms;

    @GetMapping("/loginForm")
    public String loginForm() {
        return "member/loginForm";
    }
    @PostMapping("/login")
    public String login(@ModelAttribute("dto") @Valid MemberVO membervo,
                        BindingResult result,
                        Model model,
                        HttpServletRequest request) {
        String url = "main/main";
        if(result.getFieldError("userid")!=null)
            model.addAttribute("message", result.getFieldError("userid").getDefaultMessage());
        else if (result.getFieldError("pwd")!=null)
            model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
        else{
            MemberVO mvo = ms.getMember(membervo.getUserid());
            if(mvo == null)
                model.addAttribute("message","아이디 또는 비밀번호를 확인하세요");
            else if(!mvo.getPwd().equals(membervo.getPwd()))
                model.addAttribute("message","아이디 또는 비밀번호를 확인하세요");
            else if(mvo.getPwd().equals(membervo.getPwd())) {
                HttpSession session = request.getSession();
                session.setAttribute("loginUser", mvo);
                url = "redirect:/";
            }
        }
        return url;
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("loginUser");
        return "redirect:/";
    }

    @GetMapping("/updateMemberForm")
    public String updateMemberForm(HttpServletRequest request) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("loginUser");

        if(mvo == null){
            return "member/loginForm";
        }else{
            return "member/updateMember";
        }
    }


    @GetMapping("/kakaostart")
    public @ResponseBody String kakaostart(){
        String a = "<script type='text/javascript'>"
                + "location.href='http://kauth.kakao.com/oauth/authorize?"
                + "client_id=0d1c52079a64f14e109fa8b905caa368"
                + "&redirect_uri=http://localhost:8070/kakaoLogin"
                + "&response_type=code'"
                + "</script>";
        return a;
    }

    @GetMapping("/kakaoLogin")
    public String login(HttpServletRequest request) throws IOException {
        String code = request.getParameter("code");
        System.out.println(code); // 토큰 출력

        // 실제 User info 를 요청할 url 과 전달인수 설정
        String endpoint="https://kauth.kakao.com/oauth/token";
        URL url = new URL(endpoint); // import java.net.URL; 예외처리 add throws 로 처리
        String bodyData="grant_type=authorization_code";
        bodyData += "&client_id=0d1c52079a64f14e109fa8b905caa368";
        bodyData += "&redirect_uri=http://localhost:8070/kakaoLogin";
        bodyData += "&code="+code;

        //Stream 연결
        HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // import - java.net.HttpURLConnection;
        //http header 값 넣기( 요청 내용에 헤더 추가 )
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
        conn.setDoOutput(true);

        //인증 절차를 완료하고 User info 요청을 위한 정보를 요청 및 수신합니다.
        BufferedWriter bw = new BufferedWriter(
                new OutputStreamWriter(conn.getOutputStream(), "UTF-8")
        );
        bw.write(bodyData);
        bw.flush();
        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream(),"UTF-8")
        );

        String input="";
        StringBuilder sb = new StringBuilder(); // 조각난 String 을 조립하기 위한 객체
        while((input=br.readLine())!=null){
            sb.append(input);
            System.out.println(input);
        }

        // 사용자가 실제로 동의한 항목들만 요청하고 받을 수 있도록 권한을 갖고 있는 새로운 토큰으로 구성
        //{"access_token":"S_d0uX4j8cT7GJQRwsZAZ9vKbBrKHv_yAAAAAQo9c04AAAGQLpqQtyn2EFsnJsRZ","token_type":"bearer",
        // "refresh_token":"c8JF76KEY91s7vcAbXN8s7vA3z_g8jyzAAAAAgo9c04AAAGQLpqQtCn2EFsnJsRZ","expires_in":21599,
        // "scope":"profile_nickname","refresh_token_expires_in":5183999}

        // 수신내용을 Gson 으로 변경 (파싱) 하고 준비된 객체에 옮겨 담습니다.
        Gson gson = new Gson();
        OAuthToken oAuthToken=gson.fromJson(sb.toString(), OAuthToken.class);
        // oAuthToken <- sb{"access_token":"HCqlu2GvtrRSqZxYLVfvI_hS5UWBqR....
        // sb 내용을 항목에 맞춰서 OAuthToken 객체에 옮겨 담습니다.

        // 실제 정보 요청 및 수신
        String endpoint2="https://kapi.kakao.com/v2/user/me";
        URL url2 = new URL(endpoint2);
        // import java.net.HttpConnection
        HttpURLConnection conn2= (HttpURLConnection) url2.openConnection();
        // header 값 넣기
        conn2.setRequestProperty("Authorization","Bearer " +oAuthToken.getAccess_token());
        conn2.setDoOutput(true);
        //Userinfo 수신
        BufferedReader br2 = new BufferedReader(
                new InputStreamReader(conn2.getInputStream(),"UTF-8")
        );
        String input2="";
        StringBuilder sb2 = new StringBuilder();
        while((input2=br2.readLine())!=null){
            sb2.append(input2);
            System.out.println(input2);
        }
        //  수신내용
        // {"access_token":"S_d0uX4j8cT7GJQRwsZAZ9vKbBrKHv_yAAAAAQo9c04AAAGQLpqQtyn2EFsnJsRZ",
        // "token_type":"bearer","refresh_token":"c8JF76KEY91s7vcAbXN8s7vA3z_g8jyzAAAAAgo9c04AAAGQLpqQtCn2EFsnJsRZ","expires_in":21599,
        // "scope":"profile_nickname","refresh_token_expires_in":5183999}
        //{"id":3586515237,"connected_at":"2024-06-19T03:45:48Z","properties":{"nickname":"이대승"},
        // "kakao_account":{"profile_nickname_needs_agreement":false,"profile":{"nickname":"이대승","is_default_nickname":false}}}

        Gson gson2 = new Gson();
        KakaoProfile kakaoProfile=gson2.fromJson(sb2.toString(), KakaoProfile.class);
        System.out.println(kakaoProfile.getId());
        KakaoProfile.KakaoAccount ac =kakaoProfile.getAccount();
        System.out.println(ac.getEmail());
        KakaoProfile.KakaoAccount.Profile pf =ac.getProfile();
        System.out.println(pf.getNickname());

        MemberVO mvo = ms.getMember(kakaoProfile.getId());
        if(mvo == null){
            mvo = new MemberVO();
            mvo.setUserid(kakaoProfile.getId());
            // mdto.setEmail.(ac.getEmail());
            mvo.setEmail("kakao");
            mvo.setName(pf.getNickname());
            mvo.setProvider("kakao");
            mvo.setPwd("kakao");
            mvo.setPhone("");
            ms.insertMember(mvo);
        }
        HttpSession session = request.getSession();
        session.setAttribute("loginUser", mvo);
        return "redirect:/";

    }

}
