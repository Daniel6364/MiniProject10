<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<meta charset="EUC-KR">
<title>addPurchase.jsp</title>

<!-- CDN(Content Delivery Network) 호스트 사용 -->
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

var tranNo = ${ purchase.tranNo };
console.log("tranNo 확인 : " + tranNo)
$("form").attr("method", "POST").attr("action", "/purchase/updatePurchase?tranNo=${ purchase.tranNo }")

</script>
</head>

<body>

<!-- <form name="updatePurchase" action="/purchase/updatePurchase?tranNo=${ purchase.tranNo }" method="post"> -->
<form name="updatePurchase">

▶ 다음과 같이 구매가 되었습니다.

<table border=1>
	<tr>
		<td>물품번호</td>
		<td>${ purchase.purchaseProd.prodNo }</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자아이디</td>
		<td>${ purchase.buyer.userId}</td>
		<td></td>
	</tr>
	<tr>
		<td>구매방법</td>
		<td>
			${ purchase.paymentOption == '1  ' ? "현금구매" : "신용구매" }
		</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자이름</td>
		<td>${ purchase.receiverName }</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자연락처</td>
		<td>${ purchase.receiverPhone }</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자주소</td>
		<td>${ purchase.dlvyAddr }</td>
		<td></td>
	</tr>
		<tr>
		<td>구매요청사항</td>
		<td>${ purchase.dlvyRequest }</td>
		<td></td>
	</tr>
	<tr>
		<td>배송희망일자</td>
		<td>${ purchase.dlvyDate }</td>
		<td></td>
	</tr>
</table>
</form>

</body>
</html>