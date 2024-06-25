package com.goods.g1.controller;

import com.goods.g1.dto.MemberVO;
import com.goods.g1.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberController {

    @Autowired
    MemberService ms;

    @GetMapping("/")
    public String index() {
        return "main/main";
    }

    @GetMapping("/loginForm")
    public String loginForm() {
        return "member/loginForm";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute("dto") MemberVO membervo,
                        HttpServletRequest request, BindingResult result, Model model) {
        String url = "member/loginForm";
        if (result.getFieldError("userid") != null)
            model.addAttribute("message",
                    result.getFieldError("userid").getDefaultMessage());
        else if (result.getFieldError("pwd") != null)
            model.addAttribute("message",
                    result.getFieldError("pwd").getDefaultMessage());
        else {
            MemberVO mvo = ms.getMember(membervo.getUserid());
            if (mvo == null)
                model.addAttribute("message", "아이디/비번 확인 안하나!!");
            else if (!mvo.getPwd().equals(membervo.getPwd()))
                model.addAttribute("message", "아이디/비번 확인 안하나!!");
            else if (mvo.getPwd().equals(membervo.getPwd())) {
                HttpSession session = request.getSession();
                session.setAttribute("loginUser", mvo);
                url = "redirect:/";
            }
        }
        return url;
    }

    @GetMapping("/joinPage")
    public String joinPage() {
        return "member/JoinPage";
    }

    @GetMapping("/IDCheck")
    public ModelAndView IDCheck(@RequestParam("userid") String userid){
        ModelAndView mav = new ModelAndView();
        MemberVO mvo = ms.getMember(userid);

        if (mvo == null) {
            mav.addObject("result", -1);
        }else
            mav.addObject("result", 1);
        mav.addObject("userid", userid);
        mav.setViewName("member/IDCheckPage");
        return mav;
    }


    @PostMapping("/join")
    public String join(@ModelAttribute("dto") MemberVO membervo,
                       BindingResult result, Model model,
                       @RequestParam(value = "reid", required = false) String reid,
                       @RequestParam(value = "pwdCheck", required = false) String pwdCheck) {

        String url = "member/joinPage";
        model.addAttribute("reid", reid);
        if (result.getFieldError("userid") != null)
            model.addAttribute("message", result.getFieldError("userid").getDefaultMessage());
        else if (result.getFieldError("pwd") != null)
            model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
        else if (result.getFieldError("name") != null)
            model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
        else if (result.getFieldError("phone") != null)
            model.addAttribute("message", result.getFieldError("phone").getDefaultMessage());
        else if (result.getFieldError("email") != null)
            model.addAttribute("message", result.getFieldError("email").getDefaultMessage());
        else if (reid == null || (!reid.equals(membervo.getUserid())))
            model.addAttribute("message", "아이디 중복체크하세요!!");
        else if (pwdCheck == null || (!pwdCheck.equals(membervo.getPwd())))
            model.addAttribute("message", "비밀번호 일치시키세요!!");
        else {
            url = "member/login";
            model.addAttribute("message", "회원가입 성공, 로그인하세요~");
            ms.insertMember(membervo);
        }
        return url;
    }

}
