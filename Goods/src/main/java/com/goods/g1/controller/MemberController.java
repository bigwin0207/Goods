package com.goods.g1.controller;

import com.goods.g1.dto.KakaoProfile;
import com.goods.g1.dto.MemberVO;
import com.goods.g1.dto.OAuthToken;
import com.goods.g1.service.MemberService;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.apache.logging.log4j.message.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.server.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.io.*;
import java.net.Authenticator;
import java.net.HttpURLConnection;
import java.net.PasswordAuthentication;
import java.net.URL;
import java.util.Properties;
import java.util.Random;

@Controller
public class MemberController {
    @Autowired
    MemberService ms;

    private static final long CODE_EXPIRATION_DURATION = 3 * 60 * 1000;

    @GetMapping("/loginForm")
    public String loginForm() {
        return "member/loginForm";
    }
    @PostMapping("/login")
    public String login(@ModelAttribute("dto") @Valid MemberVO membervo,
                        BindingResult result,
                        Model model,
                        HttpServletRequest request) {
        String url = "member/loginForm";
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
            }else{
            model.addAttribute("message", "관리자에게 문의하세요.");
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
    @PostMapping("/updateMember")
    public String updateMember(@ModelAttribute("dto") @Valid MemberVO membervo,
                               BindingResult result,
                               @RequestParam(value = "pwdCheck", required = false) String pwdCheck,
                               Model model,
                               HttpServletRequest request){
        String url = "member/updateMember";
        if(result.getFieldError("pwd") != null){
            model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
        }else if(result.getFieldError("name") != null){
            model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
        }else if(result.getFieldError("phone") != null){
            model.addAttribute("message", result.getFieldError("phone").getDefaultMessage());
        }else if(result.getFieldError("email") != null){
            model.addAttribute("message", result.getFieldError("email").getDefaultMessage());
        }else if(pwdCheck == null || !membervo.getPwd().equals(pwdCheck)){
            model.addAttribute("message","비밀번호 확인이 일치하지 않습니다.");
        }else{
            ms.updateMember(membervo);
            HttpSession session = request.getSession();
            session.setAttribute("loginUser", membervo);
            url = "redirect:/updatemember";
        }
        return url;
    }

    @GetMapping("/findIdForm")
    public String findIdForm() {
        return "member/findIdForm";
    }

   /* @PostMapping("/findId")
    public String findId(@ModelAttribute("dto") @Valid MemberVO membervo,
                         BindingResult result,
                         HttpServletRequest request
                         ,Model model) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        MemberVO mvo = ms.checkEmail(name, email);
        if (mvo == null) {
            model.addAttribute("message", "등록된 회원이 아닙니다");
            return "member/findIdForm";
        } else if (mvo.getEmail() == null || mvo.getName() == null || !mvo.getEmail().equals(email)
                || !mvo.getName().equals(name)) {
            model.addAttribute("message", "등록된 회원이 아닙니다");
        } else if (mvo.getEmail().equals(email) && mvo.getName().equals(name)) {
            model.addAttribute("message", "인증번호가 전송되었습니다");
            String verificationCode = generateVerificationCode();

            // 이메일 전송
            sendEmail(email, verificationCode);

            // 이메일 전송 후 작업 수행
            // 예: 세션에 인증 코드 저장 등
            HttpSession session = request.getSession();
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("verificationCodeExpiration",
                    System.currentTimeMillis() + CODE_EXPIRATION_DURATION);
            session.setAttribute("name", name);
            session.setAttribute("email", email);
        }
        return "";
    }
    // 랜덤한 6자리 숫자로 인증 코드 생성
    private static String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

    // 이메일 전송
    private static void sendEmail(String email, String verificationCode) {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.ssl.enable", "true"); // SSL 활성화
        properties.put("mail.smtp.host", "smtp.gmail.com"); // SMTP 호스트
        properties.put("mail.smtp.port", "465"); // SMTP 포트 (SSL 사용 시)

        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
            // 이메일 주소가 null 이 아닌 경우에만 이메일 주소를 설정합니다.
            if (email != null && !email.isEmpty()) {
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                // 이메일 제목 설정
                message.setSubject("이메일 인증 코드");

                // 이메일 본문 설정
                String emailContent = "안녕하세요, 이메일 인증 코드는 다음과 같습니다: " + verificationCode;
                message.setText(emailContent);

                // 이메일 전송
                Transport.send(message);

                System.out.println("이메일이 성공적으로 전송되었습니다.");
            } else if (email == null || email.isEmpty()) {
                // 이메일 주소가 null 이거나 비어있는 경우에 대한 처리를 수행합니다.
                System.out.println("이메일 주소가 올바르지 않습니다.");

                return; // 메서드 종료
            }

        }

    }*/


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
