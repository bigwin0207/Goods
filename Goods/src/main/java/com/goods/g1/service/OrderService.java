package com.goods.g1.service;

import com.goods.g1.dao.IGoodsDAO;
import com.goods.g1.dao.IOrderDAO;
import com.goods.g1.dto.CartVO;
import com.goods.g1.dto.GoodsVO;
import com.goods.g1.dto.MemberVO;
import com.goods.g1.dto.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
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
            ovo.setZip_code(mvo.getZip_code());
            ovo.setAddress(mvo.getAddress());
            ovo.setD_address(mvo.getD_address());
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
        ovo.setZip_code(mvo.getZip_code());
        ovo.setAddress(mvo.getAddress());
        ovo.setD_address(mvo.getD_address());
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
}
