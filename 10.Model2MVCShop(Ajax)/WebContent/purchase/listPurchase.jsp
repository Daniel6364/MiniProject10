<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="EUC-KR">
<title>listPurchase.jsp</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<!-- CDN(Content Delivery Network) 호스트 사용 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

//검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
function fncGetList(currentPage) {
//	document.getElementById("currentPage").value = currentPage;
// 	document.detailForm.submit();
	$("#currentPage").val(currentPage)
	$('form').attr("method", "POST").attr("action", "/purchase/listPurchase").submit();

}


$( function(){
	$('.ct_list_pop td:nth-child(1)').bind("click", function(){
		var tranNo = $( $('input[name="tranNo"]')[$('.ct_list_pop td:nth-child(1)').index(this)] ).val(); 
		self.location = "/purchase/getPurchase?tranNo=" + tranNo
	});
});


$( function(){
	$('.ct_list_pop td:nth-child(3)').bind("click", function(){
		var buyerUserId = $( $('input[name="buyerUserId"]')[$('.ct_list_pop td:nth-child(3)').index(this)] ).val(); 
		self.location = "/user/getUser?userId=" + buyerUserId
	});
});


$( function(){
	$('.ct_list_pop td:contains("물건도착")').bind("click", function(){
		var tranNo = $( $('input[name="tranNo"]')[$('.ct_list_pop td:nth-child(11)').index(this)] ).val(); 
		self.location = "/purchase/updateTranCode?tranNo=" + tranNo + "&tranCode=2" 
	});
});		
		
		
		
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<!-- <form name="detailForm" action="/purchase/listPurchase" method="post"> -->
<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td colspan="11" >
			전체  ${ resultPage.totalCount } 건수, 현재 ${ resultPage.currentPage } 페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${ list }">
		<c:set var="i" value="${ i + 1 }" />
	<tr class="ct_list_pop">
		<td align="center">
			<input type="hidden" name="tranNo" value="${ purchase.tranNo }">${ i }</input>
		<!-- <a href="/purchase/getPurchase?tranNo=${ purchase.tranNo }">${ i }</a> -->
		</td>
		<td></td>
		<td align="left">
			<input type="hidden" name="buyerUserId" value="${ purchase.buyer.userId }">${ purchase.buyer.userId }</input>
		<!-- <a href="/user/getUser?userId=${ purchase.buyer.userId }">${ purchase.buyer.userId }</a> -->
		</td>
		<td></td>
		<td align="left">${ purchase.receiverName }</td>
		<td></td>
		<td align="left">${ purchase.receiverPhone }</td>
		<td></td>
		<td align="left"> 현재
			<c:if test="${ purchase.tranCode == '0' }">
				구매완료
			</c:if>
			<c:if test="${ purchase.tranCode == '1' }">
				배송중
			</c:if>
			<c:if test="${ purchase.tranCode == '2' }">
				배송완료
			</c:if> 상태 입니다.
		</td>
		<td></td>
		<td align="left">
			<c:if test="${ purchase.tranCode == '1' }">
				<input type="hidden" name="tranNo" value="${ purchase.tranNo }">물건도착</input>
			<!-- <a href="/purchase/updateTranCode?tranNo=${ purchase.tranNo }&tranCode=2">물건도착</a> -->
			</c:if>
		</td>
	</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
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