<%@ page language="java" import="java.sql.*,java.util.Calendar,java.util.*,com.project.util.*" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value='<%=I18nUtil.getLangBundle(request)%>'/>
<fmt:setBundle basename="message"/>

<div class="row">
		<div class=" col-xs-24">
        
        <div class="table-responsive2 mb-15 pd-10">
        
        <h4 class="text-center"><fmt:message key="checkout.tnc.title"/></h4>
  <p><strong><u>換領「智能積賞」</u></strong><br>
  <strong><u>Eco Rewards Redemption</u></strong></p>
<ol>
  <li>貨單付款或禮券換領後，恕不接受貨品更改、退換或取消。 <br>
    No revision, change of model or order cancellation can be made  once payment or redemption is settled. </li>
  <li>禮券將於確認換領交易後的15個工作天內，以郵寄方式寄到客戶登記之通訊地址。 <br>
    Coupons will be mailed to customers&rsquo; correspondence address  within 15 working days upon successful redemption. </li>
</ol>
<br>
<p><strong><u>智能家品訂單</u></strong><br>
<strong><u>Eco Appliances Orders </u></strong></p>

<ol start="3">
<li>選購自行換領產品之顧客，必須在收到中電確認電郵的十個工作天後才開始到選定兌換地點換領產品，並於一個月內完成換領。 <br>
For self-pickup product, customers can collect the products at the selected location <u>after <span style="color:blue;">ten</span> working days upon receiving the confirmation email</u> and <u>within one month of receiving the confirmation email</u>. 
</li>


  <li>大昌行電器管家」於收到中電確認電郵的七個工作天內聯絡客户安排送貨事宜. 客户亦可致電「大昌行電器管家」熱線2262 1138查詢產品詳情,預約或更改送貨及安裝等服務。 <br>
    DCH Electrical Appliances Butler (DCH EAB) will contact customer  within 7 working days from the date of purchase to arrange goods delivery. Or  please call DCH Electrical Appliances Butler Hotline: 2262 1138 for product  information, changing delivery and installation appointment.</li>
  <li>如產品被檢查有出廠缺陷，或非因不當使用、安裝或其他人為因素造成損壞，顧客於購買日起30天內可更換相同型號之產品。如該產品型號缺貨，本公司有權更換另一款類似之型號予客人。辦理更換產品手續時，顧客必須出示該產品之有效發票或保用証。需更換之產品必須沒有損壞、花損及曾經濕水之現象。 <br>
    We guarantee free replacement for product found to have  manufacturing defect, or the defect is not caused by improper use and  installation or other human factors within 30 days from the date of purchase.  In case of that product being out of stock, we reserve the right to replace it  by another available model. Customer must present a valid original invoice and  warranty certification at the time of replacement. Product to be returned  should not be damaged, stretched, defaced or contains any trace of water damage  etc.</li>
  <li>中電銷售的產品只限家庭使用。所有產品均由香港代理商提供原廠保用。保用限期及範圍由個別代理商自訂。客户可跟據保養卡上資料與有關代理商直接聯絡安排保用及售後服務。 <br>
    The product(s) offered by CLP POWER is/are for household use  only. Warranty service is offered by individual local agent and the warranty  period and coverage are subject to change. Customer should contact the agent  direct on all matters related to warranty and other after-sales services.</li>
  <li>如客户自行安裝產品, 因安裝而導致產品有損壞或其他損失, 本公司、大昌行電器管家及代理商恕不負責。代理商亦有權拒絕為該產品提供免費保用或維修服務。 <br>
    If you install the appliance on your own, CLP Power, DCH EAB and  agent are not responsible for any problem or defect arising therefrom. Agent  also reserves the right to refuse provision of free product warranty and/or  maintenance service.</li>
  <li>如客户不當使用或保養產品而導致產品有損壞, 本公司、大昌行電器管家及代理商恕不負責。代理商亦有權拒絕為該產品提供免費保用或維修服務。 <br>
    CLP Power, DCH EAB &amp; agent are not responsible for any kind  of product problem or defect if it is caused by improper use or handling. Agent  also reserves the right to refuse provision of free product warranty and/or  maintenance service.</li>
  <li>如環境因素或打理不善而導致產品有損壞, 本公司、大昌行電器管家及代理商恕不負責。代理商亦有權拒絕為該產品提供免費保用或維修服務。 <br>
    CLP Power, DCH DAB &amp; agent are not responsible for any  product defect or damage if it is caused by poor maintenance, improper use or  handling or environmental factors. Agent also reserves the right to refuse  provision of free product warranty and/or maintenance service.</li>
  <li>若產品出現問題而導致使用者有任何損失, 本公司可考慮退回有關產品的貨款, 而不會作出任何賠償。 <br>
    If you suffer any loss due to the defect of our products, we may  consider giving you a refund of the product price conditional on your signing a  discharge in favour of CLP Power, DCH DAB &amp; agent. However, no further  compensation will be offered.</li>
  <li>若有任何原因導致延誤或不能依期完成送貨或安裝, 客户不能因此要求退款, 更換或賠償。 <br>
    If delivery or installation is delayed, postponed or cancelled  due to traffic, weather, building structure or whatsoever reasons, we are not  responsible for any compensation, product exchange or refund.</li>
  <li>除中電指定的電器產品在議定的日期內安排送貨或提取貨品外, 客戶必須由購買日後30天內安排送貨或提取貨品, 否則此單將被註消。客戶購買預訂的電器產品，如未能於議定時間內安排送貨或提取貨品, 此單將被註消, 代理商不會退還巳繳款項。 <br>
    The good(s) must be delivered or collected within 30 days from  the date of purchase, except the appliance(s) specified by CLP POWER with a  confirmed date of delivery or collection; otherwise, the order(s) will be  cancelled. For reserved appliance order(s), if customer cannot arrange for  delivery or collection of good(s) on or before the confirmed date, the order(s)  will be cancelled. The dealers shall not accept requests for any refund.
     
  </li>
  
  <li>從此處收集的個人資料可供中電作以下用途:<br>
          All personal data collected from this document are allowed for  CLP Power for the following use:<br> <ul>
        <li>
          提供送貨及安裝服務。 <br>
          To provide delivery, installation and related services</li>
        <li>進行客户意見及市場調查。 <br>
          To conduct customer opinion and market survey</li>
        <li>提供客户有關本公司最新推廣活動，優惠及產品信息。 <br>
          To inform the latest news on product, promotion offer and  company activities.</li>
       
      </ul>
      若客户不欲收取宣傳資料，可致電中電資詢通2678  2678 <a href="mailto:或電郵至csd@clp.com.hk">或電郵至csd@clp.com.hk</a>。 <br>
          If you do not wish to receive such information from us, please  call CLP INFO-LINE at 26782678 or email to <a href="mailto:csd@clp.com.hk">csd@clp.com.hk</a>.</li>

  <li>本公司有權增加, 減少或修改以上任何條款及字句,恕不另行通告. 上文文意均以英文作準。如有任何爭議, 中電保留最終決定權。 <br>
    We reserve the right to add, delete or amend any clauses or  wordings without prior notice to customers. In case of discrepancy in the  English and Chinese, the English version shall prevail. In case of any  disputes, CLP Power&rsquo;s decision shall be final. </li>
 
</ol>
<br>
<p>CLP Power Hong Kong Limited</p>
<p>Company Contact: 26782626</p>
<p>Email Address: <a href="mailto:csd@clp.com.hk">csd@clp.com.hk</a></p>
<p>Address: 8 Laguna Verde Avenue, Hung Hom, Kowloon, Hong Kong</p>

</div>
          <div class="checkbox">
          		<input id="tncCheckout" type="checkbox" name="tncCheckout">
            	<label for="tncCheckout"><fmt:message key="checkout.tnc.agreee"/></label>
          </div>
           
	     </div><!--xs-24-->
     	</div><!--row-->