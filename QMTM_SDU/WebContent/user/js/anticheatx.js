
////////////////////////////////////////////////////////
//						AntiCheatX ����					//
////////////////////////////////////////////////////////

// TrayProgram ���� ( ����� Alt+F4 ��������)
function StartTrayProgram() {
	// �������� ���α׷��� �ִ��� Ȯ��
	/*
	var check;
	check=document.AntiCheatX.ExternalAppExist();
	if (check == "TRUE")
	{
		alert("�������� �ٸ� ���α׷����� �����Ͽ� �ֽʽÿ�..");
		return;
	}
	*/
	// ���α׷� ���� 
	var v_test;
	document.AntiCheatX.ShellTrayRefresh();
	v_test = document.AntiCheatX.StartTrayProgram();
}

// TrayProgram ����
function EndTrayProgram(){
	var v_test = document.AntiCheatX.EndTrayProgram();
	document.AntiCheatX.ShellTrayRefresh();
}

// ��� ����� Ȯ��
function DualMonitorCheck() {
	var v_NonDualMonitor;
	v_NonDualMonitor=document.AntiCheatX.CheckDualMonitor();
	if (v_NonDualMonitor=="TRUE")	{
	}
	else alert("Dual Monitor ������ �����Ͻʽÿ�..");
}

// ActiveX ��ġ ���� Ȯ��
function ActiveX_YN() {
	
	var ret;
	ret = CheckActiveX("ANTICHEATX.AntiCheatXCtrl.1");
	if(ret){ 	   
		alert("AnticheatX�� ��ġ�Ǿ� �ֽ��ϴ�..");
	} else {
		alert("AnticheatX�� ��ġ���� �ʾҽ��ϴ�..");	
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

// hwp xml ���� local ����
function Save_Txt() {
	var data;
	//data = Hwp.GetTextFile("HWPML2X", "");
	data = Hwp.GetTextFile("HWP", "");

	var path = document.AntiCheatX.GetUserDataPath();
	
	hiddenXml.value = data;

	//alert(hiddenXml.value);

	var aa;
	aa = document.AntiCheatX.SaveTxt(path + "\\bb.txt" + "��" + data ); 

	//aa = document.AntiCheatX.SaveTxt(path + "\\aa.txt" + "��" + data ); 
	//alert(aa); 

	//<PARAM NAME="vName" VALUE="eTest/���̹�/192.168.0.110">
	//console.log(data);
}

// hwp xml ���� �ҷ�����
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

// hwp xml ���� ����
function Add_Txt() {

	//Hwp.Run("MoveDocEnd"); // ���� ���������� �̵�
	//Hwp.Run("BreakPage"); // �� ������
	
	var path = document.AntiCheatX.GetUserDataPath();

	var data;

	for (var i=0;i<2;i++ )
	{
		data = document.AntiCheatX.GetTxt(path + "\\aa.txt");
		Hwp.SetTextFile(data, "HWP", "");

		// �� ��ȣ �ű��
		var dact = Hwp.CreateAction("PageNumPos");
		var dset = dact.CreateSet();
		dset.SetItem("PageNumPos", 0);
		dact.Execute(dset);
		
		Hwp.PrintDocument();		
		
		// ���� �μ�
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
	var aa = document.AntiCheatX.GetVersion(); // ��������
	alert(aa);
	aa = document.AntiCheatX.GetOSVersion(); // OS ��������
	alert(aa);
	aa = document.AntiCheatX.CheckTrayProgramPath(); // AntiCheatX Tray ���α׷� ��ġ ���
	alert(aa);		
	aa = document.AntiCheatX.CheckTrayProgram(); // AntiCheatX Tray ���α׷� ��ġ ����
	alert(aa);
}


/////////////full â�� ���� ���ͳ� �ɼ� ����///////////////// (�ε����� ��� �̿ܿ��� ������)
//alert("InternetOption ���� ����");
/*
var InternetOption1 = document.AntiCheatX.GetInternetOption(); //������Ʈ���� ���ͳ� �ɼǰ� ������	
var	v_test=document.AntiCheatX.CheckUAC();
if ( InternetOption1 != "0" || v_test=="TRUE")		// "0" �϶� Ǯâ ����
{	
	if(v_test=="TRUE")
	{
		v_test=document.AntiCheatX.TurnOffUAC();
		if(v_test="TURE") alert("UAC turned off successfully..");
		else alert("UAC failed to be turned off..");
		//alert("ȯ�� ���� ����");
	}

	if( InternetOption1 != "0")
	{
		var InternetOption2 = document.AntiCheatX.SetInternetOption();	//���ͳ� �ɼ� ����
		if ( InternetOption2 == "TRUE")		//���ͳ� �ɼ� ���� ������
		{
			alert("���� ȯ�濡 �°� ���ͳ� �ɼ� ����");				
		}
		else
			alert(InternetOption2);
	}
	alert("���� ȯ�濡 �°� ������ ����Ǿ����ϴ�.\n�ٽ� ���ý��� �Ͻʽÿ�");
	top.window.close();				//â ����(�ٽ� â�� ���� �ϱ� ����
}	
*/
 ////////////////////////////////////////////////////////////
	
