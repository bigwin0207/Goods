package com.goods.g1.service;

import com.goods.g1.dao.IAdminGoodsDAO;
import com.goods.g1.dao.IGoodsDAO;
import com.goods.g1.dto.GoodsImageVO;
import com.goods.g1.dto.GoodsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class FileManageService {

    private final IGoodsDAO gdao;
    private final IAdminGoodsDAO adao;

    @Autowired
    public FileManageService(IGoodsDAO gdao, IAdminGoodsDAO adao) {
        this.gdao = gdao;
        this.adao = adao;
    }

    public void deleteUnusedFiles(String[] imgsToUse,  int gseq, String oldGname){
        File[] deleteTo = new File("C:\\upload\\" + gseq + oldGname).listFiles();
        if (deleteTo != null){
            for (File file : deleteTo){
                String fileName = file.getName();

                if(imgsToUse!=null && imgsToUse.length>0){
                    if (!isInArray(fileName, imgsToUse)){
                        if(file.delete()){
                            System.out.println("file deleted : " + fileName);
                        } else {
                            System.out.println("failed to delete file : " + fileName);
                        }
                    }
                } else {
                    file.delete();
                }
            }
        }
    }


    public List<GoodsImageVO> uploadNewFiles(String[] files, GoodsVO gvo){
        List<GoodsImageVO> records = new ArrayList<>();

        final String uploadPath = "C:\\upload\\" + gvo.getGseq() + gvo.getGname() + "\\";
        File uploadDir;
        String oriname = "";
        String realname = "";

        if (files != null){
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

                        GoodsImageVO givo = new GoodsImageVO();
                        givo.setOriname(oriname);
                        givo.setRealname(realname);
                        givo.setFilesize(fileSize);
                        givo.setGseq(gvo.getGseq());
                        System.out.println(givo);
                        records.add(givo);
                    } else {
                        System.out.println("failed to move file... : " + tempfile.getPath());
                    }
                } else {
                    System.out.println("file does not exists... : " + tempfile.getPath());
                }
            }
        }

        return records;
    }

    public void moveToNewDirectory(String oldGname, GoodsVO gvo){
        final String uploadPath = "C:\\upload\\" + gvo.getGseq() + gvo.getGname() + "\\";
        if (!oldGname.equals(gvo.getGname())){
            String oldPath = "C:\\upload\\" + gvo.getGseq() + oldGname + "\\";
            File[] oldFiles = new File(oldPath).listFiles();

            if (oldFiles == null|| oldFiles.length == 0) {
                System.out.println("No Files Found in the old Directory");
            }

            File newDir = new File(uploadPath);
            if (!newDir.exists()) {
                newDir.mkdirs();
            }


            for (File oldFile : oldFiles){
                if(oldFile.isFile()){
                    Path oldFilePath = Paths.get(oldFile.getAbsolutePath());
                    Path newFilePath = Paths.get(uploadPath, oldFile.getName());

                    try{
                        Files.move(oldFilePath, newFilePath);
                        System.out.println("file moved : " + oldFile.getName());
                    } catch (IOException e) {
                        System.err.println("failed to moved file : " + oldFile.getName());
                        throw new RuntimeException(e);
                    }
                }
            }

            // 폴더도 삭제
            File oldDir = new File(oldPath);
            if (oldDir.exists()){
                oldDir.delete();
            }

        }
    }


    public boolean isInArray(String value, String[] array) {

        for (String item : array) {
            if (item.equals(value)) {
                return true;
            }
        }
        return false;
    }
}
