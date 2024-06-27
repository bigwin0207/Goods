package com.goods.g1.service;

import com.goods.g1.dao.IAdminGoodsDAO;
import com.goods.g1.dao.IGoodsDAO;
import com.goods.g1.dto.GoodsImageVO;
import com.goods.g1.dto.GoodsVO;
import com.goods.g1.util.MPaging;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminGoodsService {

    private final IAdminGoodsDAO adao;
    private final IGoodsDAO gdao;
    private final FileManageService fs;

    @Autowired
    public AdminGoodsService(IAdminGoodsDAO adao, IGoodsDAO gdao, FileManageService fs) {
        this.adao = adao;
        this.gdao = gdao;
        this.fs = fs;
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
                    adao.writeGoodsImages(new GoodsImageVO(oriname, realname, fileSize, gseq));
                } else {
                    System.out.println("failed to move file... : " + tempfile.getPath());
                }
            } else {
                System.out.println("file does not exists... : " + tempfile.getPath());
            }

        }
    }

    public Map<String, Object> goodsUpdateForm(int gseq) {
        Map<String, Object> result = new HashMap<>();

        GoodsVO gvo = gdao.getGoods(gseq);

        List<GoodsImageVO> bestImageList = gdao.getImageList(gvo.getGseq());
        gvo.setImageList(bestImageList);
        List<GoodsVO> categoryList = gdao.getAllCategories();
        result.put("categoryList", categoryList);
        result.put("updateGoods", gvo);

        return result;
    }


    @Transactional(rollbackFor = {Exception.class, Error.class})
    public void updateGoods(String[] files, String[] giseqs, String[] oldimgs, String oldGname, GoodsVO gvo) {

        adao.updateGoods(gvo);

        if(giseqs != null) {
            adao.deleteGoodsImagesWithGiseqs(giseqs, gvo.getGseq());
        } else {
            adao.deleteGoodsImagesWithoutGiseqs(gvo.getGseq());
        }

        // 사용하지 않기로 한 파일들을 기존 디렉토리에서 삭제하기
        fs.deleteUnusedFiles(oldimgs, gvo.getGseq(), oldGname);

        // 새 파일 업로드 (temps 폴더에서 실제 상품 디렉토리로 이동)
        List<GoodsImageVO> imageRecords = fs.uploadNewFiles(files, gvo);

        // 업로드된 이미지들을 실제 상품 테이블에 삽입
        imageRecords.forEach(goodsImageVO -> {
            adao.writeGoodsImages(goodsImageVO);
        });

        // 이름이 수정되었을 경우 기존 디렉토리에 있던 파일들 새 디렉토리로 옮기기
        fs.moveToNewDirectory(oldGname, gvo);






    }

}
