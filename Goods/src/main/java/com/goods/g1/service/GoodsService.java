package com.goods.g1.service;

import com.goods.g1.dao.IGoodsDAO;
import com.goods.g1.dto.GoodsImageVO;
import com.goods.g1.dto.GoodsVO;
import com.goods.g1.dto.MemberVO;
import com.goods.g1.dto.ReviewVO;
import com.goods.g1.util.MPaging;
import com.goods.g1.util.Paging;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class GoodsService {
    private final IGoodsDAO gdao;

    @Autowired
    public GoodsService(IGoodsDAO gdao) {
        this.gdao = gdao;
    }

    public HashMap<String, Object> viewCategory(String cgseq, HttpServletRequest request) {

        HashMap<String, Object> result = new HashMap<>();
        

        HttpSession session = request.getSession();
        MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");

        //페이징
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
        paging.setDisplayRow(20);
        paging.setStartNum(paging.getStartNum()-1);

        int count = gdao.getAllCount("cgseq", cgseq);
        paging.setTotalCount(count);

        //카테고리별 리스트 가져오기
        List<GoodsVO> categoryList;

        if (cgseq.equals("0")) {
            //best 50
            categoryList = gdao.getBestList();
        } else {
            //나머지 카테고리들
            categoryList = gdao.getCategoryList(cgseq, paging);
        }

        for (GoodsVO vo : categoryList) {

            List<GoodsImageVO> categoryImageList = gdao.getImageList(vo.getGseq());
            vo.setImageList(categoryImageList);

            // 사용자별 가격표시
            if (loginUser != null) {
                int oldPrice = vo.getS_price();
                int newPrice = 0;

                newPrice = (int) Math.ceil(oldPrice - (oldPrice * loginUser.getSale()));

                vo.setS_price(newPrice);
            }
        }

        result.put("categoryList", categoryList);
        result.put("cgseq", cgseq);
        result.put("paging", paging);

        return result;
    }

    public HashMap<String, Object> viewGoodsDetail(int gseq, HttpServletRequest request) {
        HashMap<String, Object> result = new HashMap<>();

        HttpSession session = request.getSession();
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

        GoodsVO gvo = gdao.getGoods(gseq);
        List<GoodsImageVO> image = gdao.getImageList(gseq);
        gvo.setImageList(image);

        if (loginUser != null) {
            int oldPrice = gvo.getS_price();
            int newPrice = 0;

            newPrice = (int) Math.ceil(oldPrice - (oldPrice * loginUser.getSale()));

            gvo.setS_price(newPrice);
        }

        result.put("goods", gvo);



/*        ReviewDAO rDAO = ReviewDAO.getInstance();
        int total = rDAO.getGoodsReviewTotal(gseq);
        int currentPage = 1;

        Paging paging = new Paging(currentPage, 10, total);
        List<ReviewVO> reviewList = rDAO.getGoodsReviewList(gseq, 10, paging.getCurrentPage());*/

        return result;
    }
}
