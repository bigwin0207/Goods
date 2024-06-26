package com.goods.g1.service;

import com.goods.g1.dao.IAdminGoodsDAO;
import com.goods.g1.dao.IGoodsDAO;
import com.goods.g1.dto.GoodsImageVO;
import com.goods.g1.dto.GoodsVO;
import com.goods.g1.util.MPaging;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class AdminGoodsService {

    private final IAdminGoodsDAO idao;
    private final IGoodsDAO gdao;

    @Autowired
    public AdminGoodsService(IAdminGoodsDAO idao, IGoodsDAO gdao) {
        this.idao = idao;
        this.gdao = gdao;
    }

    public HashMap<String, Object> adminGoodsView(MPaging paging) {
        HashMap<String, Object> result = new HashMap<>();

        int count = gdao.getAllCount("cgseq", "");
        paging.setTotalCount(count);

        List<GoodsVO> adminGoodsList = gdao.getAllGoods("", paging);

        for (GoodsVO gvo : adminGoodsList) {
            List<GoodsImageVO> bestImageList = gdao.getImageList(gvo.getGseq());
            gvo.setImageList(bestImageList);
        }

        result.put("adminGoodsList", adminGoodsList);
        result.put("paging", paging);

        return result;
    }

    public List<GoodsVO> adminGoodsInsertForm() {
        return gdao.getAllCategories();
    }
}
