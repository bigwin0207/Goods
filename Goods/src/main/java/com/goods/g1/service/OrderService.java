package com.goods.g1.service;

import com.goods.g1.dao.IGoodsDAO;
import com.goods.g1.dao.IOrderDAO;
import com.goods.g1.dto.CartVO;
import com.goods.g1.dto.GoodsVO;
import com.goods.g1.dto.MemberVO;
import com.goods.g1.dto.OrderVO;
import com.goods.g1.util.MPaging;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.TimeoutException;

@Service
public class OrderService {
    private final IOrderDAO odao;
    private final IGoodsDAO gdao;

    @Autowired
    public OrderService(IOrderDAO odao, IGoodsDAO gdao) {
        this.odao = odao;
        this.gdao = gdao;
    }


    public List<OrderVO> orderFormCart(MemberVO mvo, String[] gseqs, String[] quantity) {

        List<OrderVO> list = new ArrayList<>();

        for(int i = 0; i<gseqs.length; i++) {
            int gseqInt = Integer.parseInt(gseqs[i]);

            GoodsVO gvo = gdao.getGoods(gseqInt);
            gvo.setImageList(gdao.getImageList(gseqInt));

            OrderVO ovo = new OrderVO();
            ovo.setUserid(mvo.getUserid());
            ovo.setName(mvo.getName());
            ovo.setZip_num(mvo.getZip_num());
            ovo.setAddress1(mvo.getAddress1());
            ovo.setAddress2(mvo.getAddress2());
            ovo.setAddress3(mvo.getAddress3());
            ovo.setPhone(mvo.getPhone());
            ovo.setGseq(gseqInt);
            ovo.setGname(gvo.getGname());
            ovo.setRealname(gvo.getImageList().get(0).getRealname());
            ovo.setQuantity(Integer.parseInt(quantity[i]));

            int oldPrice = gvo.getS_price();
            int newPrice = 0;

            newPrice = (int)Math.ceil(oldPrice - (oldPrice * mvo.getSale()));

            gvo.setS_price(newPrice);
            ovo.setTotalprice(gvo.getS_price());

            list.add(ovo);
        }

        return list;
    }

    public List<OrderVO> orderDirectly(MemberVO mvo, String gseqS, String quantity) {

        int gseq = Integer.parseInt(gseqS);

        GoodsVO gvo = gdao.getGoods(gseq);
        gvo.setImageList(gdao.getImageList(gseq));

        List<OrderVO> list = new ArrayList<OrderVO>();

        OrderVO ovo = new OrderVO();
        ovo.setUserid(mvo.getUserid());
        ovo.setName(mvo.getName());
        ovo.setZip_num(mvo.getZip_num());
        ovo.setAddress1(mvo.getAddress1());
        ovo.setAddress2(mvo.getAddress2());
        ovo.setAddress3(mvo.getAddress3());
        ovo.setPhone(mvo.getPhone());
        ovo.setGseq(gseq);
        ovo.setGname(gvo.getGname());
        ovo.setQuantity(Integer.parseInt(quantity));
        ovo.setRealname(gvo.getImageList().get(0).getRealname());

        int oldPrice = gvo.getS_price();
        int newPrice = 0;

        newPrice = (int)Math.ceil(oldPrice - (oldPrice * mvo.getSale()));

        gvo.setS_price(newPrice);
        ovo.setTotalprice(gvo.getS_price());

        list.add(ovo);

        return list;
    }


    @Transactional(rollbackFor = {TimeoutException.class, Error.class})
    public void insertOrder(List<OrderVO> orderProductList, List<CartVO> cartlist, MemberVO mvo) {

        odao.insertOrder(mvo.getUserid());

        int oseq = odao.lookupMaxOseq(mvo.getUserid());

        for(OrderVO ovo : orderProductList) {
            odao.insertOrderDetail(ovo, oseq);

            if(cartlist != null) {
                CartVO deleteTo = cartlist.stream()
                        .filter(obj -> obj.getGseq() == ovo.getGseq())
                        .findFirst().orElse(null);

                cartlist.remove(deleteTo);
            }
        }
    }

    public HashMap<String, Object> viewOrderList(MemberVO mvo, HttpServletRequest request) {
        HashMap<String, Object> result = new HashMap<>();

        HttpSession session = request.getSession();
        int page = 1;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
            session.setAttribute("page", page);
        } else if (session.getAttribute("page") != null) {
            page = (Integer) session.getAttribute("page");
        } else {
            session.removeAttribute("page");
        }

        MPaging paging = new MPaging();
        paging.setPage(page);
        paging.setStartNum(paging.getStartNum()-1);

        int count = odao.getAllCount(mvo.getUserid(), "userid");
        paging.setTotalCount(count);

        List<OrderVO> orderList = odao.selectOrderList(mvo.getUserid(), paging);
        result.put("orderList", orderList);
        result.put("paging", paging);

        return result;
    }

    public List<OrderVO> selectOrderDetail(int oseq) {
        return odao.selectOrderDetail(oseq);
    }
}
