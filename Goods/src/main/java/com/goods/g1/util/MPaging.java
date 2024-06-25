package com.goods.g1.util;

public class MPaging {
	
	private int page=1; 
	private int totalCount; 
	private int displayRow=10; 
	private int displayPage=10;
	private int beginPage;  
    private int endPage;      	
    private boolean prev;
    private boolean next;    
    private int startNum; 
    private int endNum;
    
    private void calPaging() {
    	endPage = ( (int)( Math.ceil( page/(double)displayPage ) ) )*displayPage;
    	beginPage = endPage - (displayPage - 1);
    	int totalPage = (int)Math.ceil(totalCount/(double)displayRow);
    	if( totalPage<endPage ) { 	
    		endPage = totalPage;    next = false;				 
    	}else{ 	
    		next = true;   
    	}
    	prev = (beginPage==1)? false : true; 
    	startNum = (page-1)*displayRow+1;   
        endNum = page*displayRow;                  
        System.out.println(beginPage + " "  + endPage + " "  + startNum + " "  + endNum);
    }
    
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calPaging();  // 전체 레코드 갯수가 결정이 되면 나머지 멤버변수들이 계산됩니다
	}
	public int getDisplayRow() {
		return displayRow;
	}
	public void setDisplayRow(int displayRow) {
		this.displayRow = displayRow;
	}
	public int getDisplayPage() {
		return displayPage;
	}
	public void setDisplayPage(int displayPage) {
		this.displayPage = displayPage;
	}
	public int getBeginPage() {
		return beginPage;
	}
	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getStartNum() {
		return startNum;
	}
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	public int getEndNum() {
		return endNum;
	}
	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	@Override
	public String toString() {
		return "MPaging [page=" + page + ", totalCount=" + totalCount + ", displayRow=" + displayRow + ", displayPage="
				+ displayPage + ", beginPage=" + beginPage + ", endPage=" + endPage + ", prev=" + prev + ", next="
				+ next + ", startNum=" + startNum + ", endNum=" + endNum + "]";
	}  
	
	
}
