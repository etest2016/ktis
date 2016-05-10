
////////////////////////////////////////////////////////
//						AntiCheatX 사용법					//
////////////////////////////////////////////////////////

// TrayProgram 시작 ( 종료시 Alt+F4 누르세요)
function StartTrayProgram() {
	// 실행중인 프로그램이 있는지 확인
	/*
	var check;
	check=document.AntiCheatX.ExternalAppExist();
	if (check == "TRUE")
	{
		alert("실행중인 다른 프로그램들을 종료하여 주십시요..");
		return;
	}
	*/
	// 프로그램 시작 
	var v_test;
	document.AntiCheatX.ShellTrayRefresh();
	v_test = document.AntiCheatX.StartTrayProgram();
}

// TrayProgram 종료
function EndTrayProgram(){
	var v_test = document.AntiCheatX.EndTrayProgram();
	document.AntiCheatX.ShellTrayRefresh();
}

// 듀얼 모니터 확인
function DualMonitorCheck() {
	var v_NonDualMonitor;
	v_NonDualMonitor=document.AntiCheatX.CheckDualMonitor();
	if (v_NonDualMonitor=="TRUE")	{
	}
	else alert("Dual Monitor 설정을 해제하십시오..");
}

// ActiveX 설치 유무 확인
function ActiveX_YN() {
	
	var ret;
	ret = CheckActiveX("ANTICHEATX.AntiCheatXCtrl.1");
	if(ret){ 	   
		alert("AnticheatX가 설치되어 있습니다..");
	} else {
		alert("AnticheatX가 설치되지 않았습니다..");	
	}

	ret = document.AntiCheatX.CheckTrayProgramPath();
	alert(ret);
}

function CheckActiveX(pid)
{
	try {
		var axObj;
		axObj = new ActiveXObject(pid);
		return true;
	} catch (e) {
		return false;
	}
}

// hwp xml 파일 local 저장
function Save_Txt() {
	var data;
	//data = Hwp.GetTextFile("HWPML2X", "");
	data = Hwp.GetTextFile("HWP", "");

	var path = document.AntiCheatX.GetUserDataPath();
	
	hiddenXml.value = data;

	//alert(hiddenXml.value);

	var aa;
	aa = document.AntiCheatX.SaveTxt(path + "\\bb.txt" + "ㅩ" + data ); 

	//aa = document.AntiCheatX.SaveTxt(path + "\\aa.txt" + "ㅩ" + data ); 
	//alert(aa); 

	//<PARAM NAME="vName" VALUE="eTest/네이버/192.168.0.110">
	//console.log(data);
}

// hwp xml 파일 불러오기
function Get_Txt() {

	var path = document.AntiCheatX.GetUserDataPath();

	var data;
	data = document.AntiCheatX.GetTxt(path + "\\bb.txt");
	//data = hiddenXml.value;

	//alert(data);
	//console.log(data);
	Hwp.SetTextFile(data, "HWP", "");
	//alert(data);
}

// hwp xml 문서 연결
function Add_Txt() {

	//Hwp.Run("MoveDocEnd"); // 문서 마지막으로 이동
	//Hwp.Run("BreakPage"); // 쪽 나누기
	
	var path = document.AntiCheatX.GetUserDataPath();

	var data;

	for (var i=0;i<2;i++ )
	{
		data = document.AntiCheatX.GetTxt(path + "\\aa.txt");
		Hwp.SetTextFile(data, "HWP", "");

		// 쪽 번호 매기기
		var dact = Hwp.CreateAction("PageNumPos");
		var dset = dact.CreateSet();
		dset.SetItem("PageNumPos", 0);
		dact.Execute(dset);
		
		Hwp.PrintDocument();		
		
		// 빠른 인쇄
		//dact = Hwp.CreateAction("Print");
		//dset = dact.CreateSet();
		//dset.SetItem("Range",0);
		//dset.SetItem("PrintMethod",0);
		//dset.SetItem("ReverseOrder",0);

		//dact.Execute(dset);
	}
//BreakPage
//LinkDocument
//MoveDocEnd

}

function Get_AppData_Roaming_AntiCheatX()
{
	var aa = document.AntiCheatX.GetUserDataPath();
	alert(aa);
}


function AntiCheatX_Test(){
	// document.AntiCheatX.AboutBox();
	var aa = document.AntiCheatX.GetVersion(); // 버전정보
	alert(aa);
	aa = document.AntiCheatX.GetOSVersion(); // OS 버전정보
	alert(aa);
	aa = document.AntiCheatX.CheckTrayProgramPath(); // AntiCheatX Tray 프로그램 설치 경로
	alert(aa);		
	aa = document.AntiCheatX.CheckTrayProgram(); // AntiCheatX Tray 프로그램 설치 유무
	alert(aa);
}


/////////////full 창을 위해 인터넷 옵션 변경///////////////// (부득이한 경우 이외에는 사용안함)
//alert("InternetOption 변경 시작");
/*
var InternetOption1 = document.AntiCheatX.GetInternetOption(); //레지스트에서 인터넷 옵션값 가져옴	
var	v_test=document.AntiCheatX.CheckUAC();
if ( InternetOption1 != "0" || v_test=="TRUE")		// "0" 일때 풀창 가능
{	
	if(v_test=="TRUE")
	{
		v_test=document.AntiCheatX.TurnOffUAC();
		if(v_test="TURE") alert("UAC turned off successfully..");
		else alert("UAC failed to be turned off..");
		//alert("환경 설정 변경");
	}

	if( InternetOption1 != "0")
	{
		var InternetOption2 = document.AntiCheatX.SetInternetOption();	//인터넷 옵션 변경
		if ( InternetOption2 == "TRUE")		//인터넷 옵션 변경 성공시
		{
			alert("시험 환경에 맞게 인터넷 옵션 변경");				
		}
		else
			alert(InternetOption2);
	}
	alert("시험 환경에 맞게 설정이 변경되었습니다.\n다시 응시시작 하십시오");
	top.window.close();				//창 종료(다시 창을 띄우게 하기 위해
}	
*/
 ////////////////////////////////////////////////////////////
	
