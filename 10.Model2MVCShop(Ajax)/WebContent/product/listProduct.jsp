<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
<meta charset="EUC-KR">
<title>listProduct.jsp</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) 호스트 사용 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

//검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
function fncGetList(currentPage) {
	
	$("#currentPage").val(currentPage);
	$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${ menu }").submit();
	console.log("fncGetList")
}

function fncLowPrice(currentPage) {
   	
	$("#currentPage").val(currentPage)
   	$("#lowPriceSearch").val("lowPrice")
 	$("#highPriceSearch").val(null)
	$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${ menu }").submit();
}
 
function fncHighPrice(currentPage) {
	
	$("#currentPage").val(currentPage)
   	$("#lowPriceSearch").val(null)
   	$("#highPriceSearch").val("highPrice")
	$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${ menu }").submit();
}

$(function(){
	$( "td.ct_btn01:contains('검색')").bind("click", function(){
		fncGetList('${ search.currentPage }');
	});
});

$(function(){
	$(".lowPrice:contains('[낮은가격순 ▼]')").bind("click", function(){
		fncLowPrice('${ search.currentPage }');
	});
});
				
$(function(){
	$(".highPrice:contains('[높은가격순 ▲]')").bind("click", function(){
		fncHighPrice('${ search.currentPage }');
	});
});

$(function(){
	
	$( ".ct_list_pop td:nth-child(5)" ).bind("mouseenter" , function() {
		
		var proTranCode = $( $('input[name="proTranCode"]')[$( ".ct_list_pop td:nth-child(5)" ).index(this)] ).val();
		var prodNo = $( $('input[name="prodNo"]')[$( ".ct_list_pop td:nth-child(5)" ).index(this)] ).val();
		
		if ( "${user.userId}" != 'admin' && "${user.userId}" != 'manager' ) { 
			if (proTranCode == '' || proTranCode == null) {
			
			//	self.location ="/product/getProduct?prodNo=" + prodNo + "&menu=${ menu }";
			var prodName = $(this).text().trim();
				$.ajax (
						{
							url : "/product/json/getProduct/" + prodNo ,
							method : "GET",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								var displayValue = "<h3>"
													+"상 품 번 호  : " + JSONData.prodNo + "<br/>"
													+"상 품 명 : " + JSONData.prodName + "<br/>"
													+"상품이미지 : " + JSONData.fileName + "<br/>"
													+"상품상세정보 : " + JSONData.prodDetail + "<br/>"
													+"제 조 일 자 : " + JSONData.manuDate + "<br/>"
													+"가 격 : " + JSONData.price + " 원 <br/>"
													+"등 록 일 자 : " + JSONData.regDate + "<br/>"
													+ "</h3>";

								$("h3").remove();
								$("h1").remove();					
								$( "#"+prodName+"" ).html(displayValue);
							}
					
				}); // end of $.ajax
				
			} else if (proTranCode != null) {
				
				var prodName = $(this).text().trim();
				$.ajax (
						{
							url : "/product/json/getProduct/" + prodNo ,
							method : "GET",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {
								var displayValue = '<h1><font color="red">' + "해당상품은 현재 구매하실 수 없습니다. [재고없음]" 
													+ "</font></h1><br/>"
													+ "<h3>"
													+"상 품 번 호  : " + JSONData.prodNo + "<br/>"
													+"상 품 명 : " + JSONData.prodName + "<br/>"
													+"상품이미지 : " + JSONData.fileName + "<br/>"
													+"상품상세정보 : " + JSONData.prodDetail + "<br/>"
													+"제 조 일 자 : " + JSONData.manuDate + "<br/>"
													+"가 격 : " + JSONData.price + " 원 <br/>"
													+"등 록 일 자 : " + JSONData.regDate + "<br/>"
													+ "</h3>";
													
								$("h3").remove();
								$("h1").remove();
								$( "#"+prodName+"" ).html(displayValue);
							}
				}); // end of $.ajax
			}
		} 
		
	});
		
});

$(function(){
	
	$( ".ct_list_pop td:nth-child(5)" ).bind("click" , function() {
		
		var proTranCode = $( $('input[name="proTranCode"]')[$( ".ct_list_pop td:nth-child(5)" ).index(this)] ).val();
		var prodNo = $( $('input[name="prodNo"]')[$( ".ct_list_pop td:nth-child(5)" ).index(this)] ).val();
		
		if ( "${user.userId}" != 'admin' && "${user.userId}" != 'manager' ) { 
			if (proTranCode == '' || proTranCode == null) {
				self.location ="/product/getProduct?prodNo=" + prodNo + "&menu=${ menu }";
			} else {
				alert("해당상품은 현재 구매하실 수 없습니다.")
			}
		} else {
			self.location ="/product/getProduct?prodNo=" + prodNo + "&menu=${ menu }";
		}
	
	});
});


$(function(){
	$( ".ct_list_pop td:nth-child(11):contains('배송하기')" ).bind("click" , function() {
		
		var prodNo = $( $('input[name="prodNo"]')[$( ".ct_list_pop td:nth-child(11)" ).index(this)] ).val();
	//	self.location = "/purchase/updateTranCodeByProd?prodNo=" + prodNo + "&tranCode=1"
			
	$.ajax({
						url : "/purchase/json/updateTranCodeByProd/" + prodNo + "/1",
						method : "GET",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData, status) {
							location.reload();
						}

					}); // end of $.ajax
				});
	});
</script>
</head>


<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">
		
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						${ menu == 'manage' ? "상품관리" : "상품 목록조회" }
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
			
				<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
				<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
				
			</select>
			<input type="text" name="searchKeyword" value="${! empty search.searchKeyword ? search.searchKeyword : ""}" class="ct_input_g" style="width:200px; height:19px" />
		</td>
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
			전체  ${ resultPage.totalCount } 건수, 현재 ${ resultPage.currentPage } 페이지
		</td>
	</tr>
	
	<tr>
		<td colspan="2" class="lowPrice">
			<input type="hidden" id="lowPriceSearch" name="lowPriceCondition" value="">[낮은가격순 ▼]
		</td>
		<td colspan="2" class="highPrice">
			<input type="hidden" id="highPriceSearch" name="highPriceCondition" value="">[높은가격순 ▲]
		</td>
	</tr>

	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품이미지</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">상품 상세정보</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${ list }">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="center">
					<c:if test = "${ product.fileName == null }">
						<img src="http://placehold.it/50X50" />
					</c:if>
					<c:if test = "${ product.fileName != null }">
						<img src="/images/uploadFiles/${ product.fileName }" height="50px"/>
					</c:if>
			</td>
			<td></td>
			<td align="left">
					<input type="hidden" name="prodNo" value="${ product.prodNo }">
					<input type="hidden" name="proTranCode" value="${ product.proTranCode }">
					${ product.prodName }
			</td>
			<td></td>
			<td align="left">${ product.price }</td>
			<td></td>
			<td align="left">${ product.prodDetail }</td>
			<td></td>
			<td align="left">
				<c:if test = "${ menu == 'search' }">
					<c:if test = "${ product.proTranCode == null }">판매중</c:if> 
					<c:if test = "${ product.proTranCode != null }">재고 없음</c:if>
				</c:if>
				<c:if test = "${ menu == 'manage' }">
					<c:if test = "${ product.proTranCode == null }">판매중</c:if>
					<c:if test = "${ product.proTranCode == '0' }">구매완료 
						<input type="hidden" name="prodNo" value="${ product.prodNo }">배송하기
					</c:if>
					<c:if test = "${ product.proTranCode == '1' }">배송중</c:if>
					<c:if test = "${ product.proTranCode == '2' }">배송완료</c:if>
				</c:if>
			</td>
		</tr>
		<tr>
			<td id="${ product.prodName }" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			 <input type="hidden" id="currentPage" name="currentPage" value=""/>
			
			<jsp:include page="../common/pageNavigator.jsp"/>
				
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>
