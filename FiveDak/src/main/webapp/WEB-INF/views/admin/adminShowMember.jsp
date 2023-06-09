<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
 
<%
	String ctxPath = request.getContextPath();
%> 
    
<jsp:include page="/WEB-INF/views/header-final.jsp"/>

<jsp:include page="/WEB-INF/views/member/mypageSidebar_admin.jsp"/>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("input#MemberSearch").bind("keyup", (e) => {
			if(e.keyCode == 13) {	//  13은 엔터 검색어에서 엔터를 하면 검색하러 가도록 한다.
				
				MemberShowreset();
			}
		});
		
		
		// *** 특정 회원을 클릭하면 그 회원의 상세정보를 보여주도록 한다. *** //
		$("tr.ShowMemberDetail").click((e) => {

			const MemberId = $(e.target).parent().find("td#ShowMemberID2").text();
			location.href = "<%=ctxPath%>/admin/adminShowMemberDetail.dak?MemberId="+MemberId;
			// 절대 경로    														
		
		});		
		
		
		let vipText = $("span#vipText");
	    let colors = ["purple", "red", "blue", "green", "white"];
	    setInterval(function() {
	        let randomColor = colors[Math.floor(Math.random() * 5)];
	        vipText.css("color", randomColor);
	    }, 1000); // 5초마다 실행	
		
				
	});
	

 	
	function MemberShowreset(){
		const MemberSearchFrm = document.MemberSearchFrm;
		MemberSearchFrm.method = "get";
		MemberSearchFrm.action="adminShowMember.dak";
		MemberSearchFrm.submit();	
		
	}
</script>

<div class="col-md-9">
      <!-- 오른쪽에 들어갈 내용 -->
      		<h2>회원정보조회</h2>
		<form name="MemberSearchFrm" style="text-align: center;">
			
			<span class="mr-3" style="position: relative; top: 1px; font-weight: bold;">회원 정보 검색</span>
		
			<input type="text" id="MemberSearch" name="MemberSearch"  style="height: 35px; position: relative; top: 1px;"/>   <!--  검색어 부분 -->
			<input type="text" style="display: none;"> <%-- 조심할 것은 type="hidden" 이 아닌것이다. --%>
			
			<button type="button" class="btn btn-dark ml-2" id="member-seach-button" onclick="MemberShowreset()" >검색</button>
		</form>
		
		<c:if test="${ not empty requestScope.memberShowList}">  <%-- 회원 정보가 있다면 실행 --%> 
		
			<table class="table table-hover my-5">
			  <tr>
			    <th>회원번호</th>
			    <th>회원아이디</th>
			    <th>회원 이름</th>
			    <th>회원 이메일</th>
			    <th>회원 티어</th>
			  </tr>
			  <tbody>
			  	<c:forEach var="showMember" items="${requestScope.memberShowList}" varStatus="loop">
					 <tr class="ShowMemberDetail"  <c:if test="${loop.first}">style="background-color:  #ffa64d ;"</c:if>>
					 	
					 	<td id="ShowMemberNo">${showMember.mbrNum}</td>
					 	<td id="ShowMemberID2">${showMember.mbrId}</td>
					 	<td id="ShowMembeName">${showMember.mbrName}</td>
					 	<td id="ShowMemberEmail">${showMember.mbrEmail}</td>
					 	<td id="ShowMemberTier">
					 		${showMember.mbrTierId}
					 		<c:if test="${loop.first}">
						        <!-- 첫 번째 루프에서만 실행할 코드 -->
						        <span id="vipText" style="color:purple;"><br>VVIP</span>
						    </c:if>	
					 	</td>
					 </tr>	
				</c:forEach>	 
			  </tbody>
			</table>
			
			
			<nav class="my-5">
		        <div style='display:flex; width:100%;'>
		          <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
		       </div>		
	    	</nav>
			
       </c:if> 
       
       
        <c:if test="${ empty requestScope.memberShowList}"> <%-- 아무회원도 없을때 --%>
	        
	        <div style="text-align: center;">
				<div style="margin-top: 100px;"><i class="fad fa-exclamation fa-5x"></i></div>
				<span> 회원정보가 없습니다.</span>
			</div>
			
       </c:if> 
        
        
        
        <div style="background-color: #e6e6e6; margin-top: 20%">
				<h4 style="padding: 20px 20px;"> 도움말 </h4>
	
                <p style="padding: 0 20px 10px 20px;">
					※ 검색은 아이디, 이름, 이메일로 검색할 수 있습니다.<br>
					※ 이메일의 경우 필수로 @가 들어가야 하며 끝까지 정확하게 쓰셔야 합니다.<br>
					※ 검색을 한 후 처음으로 돌아가시려면 아무것도 쓰지 않는 상태에서 검색 버튼을 한번더 눌러주세요
				</p>
	
	
		</div>
      
      
      <!-- 오른쪽에 들어갈 내용 -->
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>
