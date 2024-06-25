package com.goods.g1.service;

import com.goods.g1.dao.ICartDAO;
import com.goods.g1.dao.IGoodsDAO;
import com.goods.g1.dto.CartVO;
import com.goods.g1.dto.GoodsVO;
import com.goods.g1.dto.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CartService {

    private final ICartDAO cdao;
    private final IGoodsDAO gdao;

    @Autowired
    public CartService(ICartDAO cdao, IGoodsDAO gdao) {
        this.cdao = cdao;
        this.gdao = gdao;
    }

    public List<CartVO> viewCartlist(MemberVO loginUser, List<CartVO> cartlist) {

        for(CartVO cvo : cartlist) {
            int oldPrice = cvo.getS_price();
            int newPrice = 0;
            newPrice = (int)Math.ceil(oldPrice - (oldPrice * loginUser.getSale()));

            cvo.setS_price(newPrice);
            cvo.setTotalprice(cvo.getQuantity() * cvo.getS_price());

            GoodsVO gvo = gdao.getGoods(cvo.getGseq());
            gvo.setImageList(gdao.getImageList(gvo.getGseq()));
            cvo.setRealname(gvo.getImageList().get(0).getRealname());
        }

        return cartlist;
    }

    public List<CartVO> addCart(HttpServletRequest request, int quantity, int gseq) {

        HttpSession session = request.getSession();

        List<CartVO> cartlist = (List<CartVO>)session.getAttribute("cartlist");
        if(cartlist == null){
            cartlist = new ArrayList<CartVO>();
        }

        MemberVO mvo = (MemberVO)session.getAttribute("loginUser");

        GoodsVO gvo = gdao.getGoods(gseq);
        gvo.setImageList(gdao.getImageList(gseq));

        CartVO cvo = new CartVO();
        cvo.setUserid(mvo.getUserid());
        cvo.setName(mvo.getName());
        cvo.setQuantity(quantity);
        cvo.setGseq(gvo.getGseq());
        cvo.setGname(gvo.getGname());
        cvo.setS_price(gvo.getS_price());
        cvo.setTotalprice(gvo.getS_price() * quantity);
        cvo.setRealname(gvo.getImageList().get(0).getRealname());

        CartVO result = cartlist.stream().filter(obj -> obj.getGseq() == gseq).findFirst().orElse(null);

        if(result != null) {
            int oldQuantity = result.getQuantity();
            result.setQuantity(oldQuantity + quantity);
        } else {
            cartlist.add(cvo);
        }

        return cartlist;
    }

    public List<CartVO> getWishList(String userid) {
        List<CartVO> list = cdao.getWishList(userid);


        return list;
    }

    public boolean addWish(int gseq, String userid, HttpServletResponse response) {
        boolean addWishSuccess = false;
        GoodsVO gvo = gdao.getGoods(gseq);
        int cnt = cdao.selectWish(userid, gseq);

        if( cnt == 0 ) {
            cdao.insertWish(userid, gvo);
            addWishSuccess = true;
        }

        return addWishSuccess;
    }

    public List<CartVO> wishtocart(List<CartVO> cartlist, MemberVO mvo, String[] gseqs) {
        for(String gseq : gseqs) {
            int gseqInt = Integer.parseInt(gseq);

            GoodsVO gvo = gdao.getGoods(gseqInt);

            CartVO cvo = new CartVO();
            cvo.setUserid(mvo.getUserid());
            cvo.setName(mvo.getName());
            cvo.setQuantity(1);
            cvo.setGseq(gvo.getGseq());
            cvo.setGname(gvo.getGname());
            cvo.setS_price(gvo.getS_price());
            cvo.setTotalprice(gvo.getS_price());

            cartlist.add(cvo);
            cdao.deleteWish(gseqInt, mvo.getUserid());
        }

        return cartlist;
    }

    public void deleteWish(MemberVO mvo, String[] gseqs) {
        for(String gseq : gseqs) {
            int gseqInt = Integer.parseInt(gseq);
            cdao.deleteWish(gseqInt, mvo.getUserid());
        }

    }



}
