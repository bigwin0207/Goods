package com.goods.g1.controller;

import com.goods.g1.dto.CartVO;
import com.goods.g1.dto.GoodsVO;
import com.goods.g1.dto.MemberVO;
import com.goods.g1.service.CartService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@Controller
public class CartController {

    private static final Logger log = LoggerFactory.getLogger(CartController.class);
    private final CartService cs;

    @Autowired
    public CartController(CartService cs) {
        this.cs = cs;
    }

    @GetMapping("viewCartlist")
    public ModelAndView viewCartlist(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String viewName = "goods/wishlistView";


        HttpSession session = request.getSession();
        //MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

        //임시!!
        MemberVO loginUser = new MemberVO();
        loginUser.setUserid("hong1"); loginUser.setPwd("1234"); loginUser.setGseq(1); loginUser.setName("홍길동");
        session.setAttribute("loginUser", loginUser);


        List<CartVO> cartlist = (List<CartVO>)session.getAttribute("cartlist");

        if (loginUser == null) {
            viewName = "redirect:/loginForm";
        } else {
            if(cartlist != null) {
                List<CartVO> list = cs.viewCartlist(loginUser, cartlist);
            }

            session.setAttribute("cartlist", cartlist);
            viewName = "goods/cartlistView";
        }

        mav.setViewName(viewName);
        return mav;
    }

    @PostMapping("addCart")
    public String addCart(HttpServletRequest request, @RequestParam("input_quantity") int quantity, @RequestParam("gseq") int gseq) {

        List<CartVO> cartlist = cs.addCart(request, quantity, gseq);

        request.getSession().setAttribute("cartlist", cartlist);
        return "redirect:/viewCartlist";
    }

    @PostMapping("deleteCart")
    public String deleteCart(HttpServletRequest request, @RequestParam("gseq") String[] gseqs) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO)session.getAttribute("loginUser");
        List<CartVO> cartlist = (List<CartVO>)session.getAttribute("cartlist");

        for(String gseq : gseqs) {
            int gseqInt = Integer.parseInt(gseq);

            CartVO deleteTo = cartlist.stream()
                    .filter(obj -> obj.getGseq() == gseqInt)
                    .findFirst().orElse(null);

            cartlist.remove(deleteTo);

        }

        session.setAttribute("cartlist", cartlist);
        return "redirect:/viewCartlist";
    }

    @GetMapping("viewWishlist")
    public ModelAndView viewWishlist(HttpServletRequest request) {

        ModelAndView mav = new ModelAndView();
        String viewName = "goods/wishlistView";

        HttpSession session = request.getSession();
        MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");

        if (loginUser == null) {
            viewName = "redirect:/loginForm";
        } else {
            List<CartVO> wishlist = null;
            String userid = loginUser.getUserid();

            wishlist = cs.getWishList(userid);

            for( CartVO cvo : wishlist) {
                int oldPrice = cvo.getS_price();
                int newPrice = 0;
                newPrice = (int)Math.ceil(oldPrice - (oldPrice * loginUser.getSale()));

                cvo.setS_price(newPrice);
            }

            mav.addObject("wishlist", wishlist);
            viewName = "goods/wishlistView";
        }

        mav.setViewName(viewName);
        return mav;
    }

    @PostMapping("addWish")
    public String addWish(HttpServletRequest request, HttpServletResponse response, @RequestParam("gseq") int gseq) throws IOException {
        HttpSession session = request.getSession();
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        String userid = loginUser.getUserid();


        boolean isAdded = cs.addWish(gseq, userid, response);

        if(!isAdded) {
            PrintWriter out = response.getWriter();
            out.print("<script>alert('이미 찜목록에 동일한 상품이 존재합니다.');</script>");
        }

        return "redirect:/viewWishlist";
    }

    @PostMapping("wishToCart")
    public String wishtocart(HttpServletRequest request, @RequestParam("gseq") String[] gseqs) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO)session.getAttribute("loginUser");
        List<CartVO> cartlist = new ArrayList<>();

        List<CartVO> list = cs.wishtocart(cartlist, mvo, gseqs);

        session.setAttribute("cartlist", list);
        return "redirect:/viewWishlist";
    }

    @PostMapping("deleteWish")
    public String deleteWish(HttpServletRequest request, @RequestParam("gseq") String[] gseqs) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO)session.getAttribute("loginUser");

        cs.deleteWish(mvo, gseqs);

        return "redirect:/viewWishlist";
    }










}
