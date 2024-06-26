package com.goods.g1.service;

import com.goods.g1.dao.IAdminGoodsDAO;
import com.goods.g1.dao.IGoodsDAO;
import com.goods.g1.dto.GoodsImageVO;
import com.goods.g1.dto.GoodsVO;
import com.goods.g1.util.MPaging;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
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

    @Transactional(rollbackFor = {RuntimeException.class, Error.class})
    public void insertGoods(String[] files, GoodsVO gvo) throws IOException {

        gdao.insertGoods(gvo);

        //직전에 추가한 goods 테이블의 gseq 가져오기
        int gseq = gdao.lookupMaxGseq();

        // 파일업로드
        // 기본 저장 경로, 사용할 변수 선언
        String uploadPath = "C:\\upload\\" + gseq + gvo.getGname() + "\\";
        File uploadDir;
        String oriname = "";
        String realname = "";

        // 가져온 임시파일 경로 문자열 배열로 반복문 실행
        for (String tempFilePath : files){

            File tempfile = new File("C:\\upload\\temps\\" + tempFilePath);


            if (tempfile.exists()){
                oriname = tempfile.getName();
                realname = String.valueOf(System.currentTimeMillis());
                uploadDir = new File(uploadPath);

                if (!uploadDir.exists()){
                    uploadDir.mkdirs();
                }

                File newFile = new File(uploadPath + realname);
                if (tempfile.renameTo(newFile)){
                    long fileSize = newFile.length();
                    System.out.println("oriname : " + oriname + " realname : " + realname + " fileSize : " + fileSize);
                    gdao.writeGoodsImages(gseq, oriname, realname, fileSize);
                } else {
                    System.out.println("failed to move file... : " + tempfile.getPath());
                }
            } else {
                System.out.println("file does not exists... : " + tempfile.getPath());
            }

        }
    }
}
