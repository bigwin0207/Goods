package com.goods.g1.controller;

import com.goods.g1.dto.CartVO;
import com.goods.g1.dto.GoodsVO;
import com.goods.g1.dto.MemberVO;
import com.goods.g1.dto.OrderVO;
import com.goods.g1.service.OrderService;
import com.goods.g1.util.MPaging;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class OrderController {

    private final OrderService os;

    @Autowired
    public OrderController(OrderService os) {
        this.os = os;
    }

    @PostMapping("orderFromCart")
    public String orderFromCart(HttpServletRequest request, @RequestParam("gseq") String[] gseqs, @RequestParam("quantity") String[] quantity) {

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("loginUser");

        if (mvo == null) {
            return "redirect:/loginForm";
        } else {

            List<OrderVO> list = os.orderFormCart(mvo, gseqs, quantity);
            session.setAttribute("orderProductList", list);
            return "goods/orderPage";
        }

    }

    @PostMapping("orderNow")
    public String orderNow(HttpServletRequest request, @RequestParam("gseq") String gseq, @RequestParam("input_quantity") String quantity) {
        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("loginUser");

        if (mvo == null) {
            return "redirect:/loginForm";
        } else {

            List<OrderVO> list = os.orderDirectly(mvo, gseq, quantity);
            session.setAttribute("orderProductList", list);
            return "goods/orderPage";
        }
    }

    @PostMapping("getPayment")
    public String getPayment(HttpServletRequest request, @RequestParam("numberOfGoods") int numberOfGoods, @RequestParam("orderTotalPrice") int totalPrice, Model model) {

        model.addAttribute("numberOfGoods", numberOfGoods);
        model.addAttribute("orderTotalPrice", totalPrice);
        return "goods/paymentPage";
    }

    @PostMapping("orderInsert")
    public String orderInsert(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<OrderVO> orderProductList = (List<OrderVO>) session.getAttribute("orderProductList");
        List<CartVO> cartlist = (List<CartVO>) session.getAttribute("cartlist");
        MemberVO mvo = (MemberVO) session.getAttribute("loginUser");

        os.insertOrder(orderProductList, cartlist, mvo);

        session.setAttribute("cartlist", cartlist);
        session.removeAttribute("orderProductList");
        return "redirect:/viewOrderList";
    }

    @GetMapping("viewOrderList")
    public ModelAndView viewOrderList(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();

        HttpSession session = request.getSession();
        MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
        String url = "";

        if (mvo == null) {
            url = "redirect:/loginForm";
        } else {

            HashMap<String, Object> result = new HashMap<>();
            result = os.viewOrderList(mvo, request);

            mav.addObject("orderList", result.get("orderList"));
            mav.addObject("paging", result.get("paging"));
            url = "mypage/orderlistView";
        }

        mav.setViewName(url);

        return mav;
    }

    @GetMapping("orderDetailView")
    public ModelAndView orderDetailView(@RequestParam("oseq") int oseq){
        ModelAndView mav = new ModelAndView("mypage/orderDetailView");

        List<OrderVO> orderDetailList = os.selectOrderDetail(oseq);

        mav.addObject("orderDetailList", orderDetailList);

        return mav;
    }

}
