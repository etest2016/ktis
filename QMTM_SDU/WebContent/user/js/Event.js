function refresh_onclick()
{
  ExamEndYN = "Y"; // CloseUsingX �� �����ϱ� ����

  EvtLog("2"); // ���ΰ�ħ
  var timeLeft = document.frmData.timeLeft.value;
  top.frames("fraTest").location.replace("etest.jsp?id_exam=" + id_exam + "&userid=" + userid + "&gindex=" + gindex + "&timeLeft=" + timeLeft);
}

function CloseUsingX()
{
  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    // ��������(X) Event Log ���� : 20
    EvtLog("20");
    myalert("������ X ��ư�� �̿��Ͽ� ����ȭ���� ����� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
  }
}

function Resize()
{
  if (log_option == "Y")
  {
    if (isWindowResized) { return; }
    isWindowResized = true;

    // âũ�⺯�� Event Log ���� : 11
    Hide();
    EvtLog("11");
    myalert("������ âũ�⸦ �����ϴ� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
    ExamEndYN = "Y"; // CloseUsingX �� �����ϱ� ������
    parent.close();
  }
}

function Move()
{
  // frameset �̿����� ���� �Ұ�
}

function WindowMoved()
{
  // â�� ��ġ ���濩��

  var top = parent.screenTop;
  var left = parent.screenLeft;

  if (orgTop != top || orgLeft != left) {
    isWindowMoved = true;
  } else {
    isWindowMoved = false;
  }
}

function CheckMove()
{
  if (log_option == "Y")
  {
    if (isWindowMoved) { return; }
    WindowMoved();

    if (isWindowMoved) {
      // â��ġ���� Event Log ���� : 12
      Hide();
      EvtLog("12");
      myalert("������ â��ġ�� �����ϴ� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
      ExamEndYN = "Y"; // CloseUsingX �� �����ϱ� ������
      parent.close();
    }
  }
}

function LostFocus()
{
  if (ignoreLostFocus) {     // Refresh, Key-Event, alert ���
    ignoreLostFocus = false;
    return;
  }

  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    // LostFocus �� ����
    if (keyCodeTabEsc == 9) { // Alt+Tab
      EvtLog("22");
      myalert("������ ����ȭ���� ����� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
      keyCodeTabEsc = 0;
    } else if (keyCodeTabEsc == 27) { // Alt+Esc
      EvtLog("23");
      myalert("������ ����ȭ���� ����� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
      keyCodeTabEsc = 0;
    }

    // ��Ŀ���̵� Event Log ���� : 13
    EvtLog("13");
    //myalert("������ ����ȭ���� ����� ���� ���������� �����մϴ�.\n\n��� ������ ����ϰ� ��ڿ��� �뺸�Ͽ����ϴ�.");
  }
}

function chkkeyup(e)
{
    var kc = event.keyCode;
    if (kc == 9 || kc == 27) { keyCodeTabEsc = kc; } // LostFocus() ���� �̿�
}

function chkkeydown(e)
{
  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    ignoreLostFocus = false;
    var kc = event.keyCode;

    if (kc == 93 || kc == 113 || kc >= 116 && kc <= 123) {
      // myalert("������ ������ Ű�� ����Ͻ� �� �����ϴ� ...");
      event.keyCode = 0;
      event.cancelBubble = true;
      event.returnValue = false;
      return false;
    }

    // ����׸�
    if (event.altKey && kc == 115) {
      // Alt + F4 (��������)
      ExamEndYN = "Y"; // CloseUsingX �� �����ϱ� ����
      Hide();
      AnsSave("F"); // remain-time ������ ���Ͽ�
      EvtLog("21");
      myalert("������ Alt + F4 �� �̿��Ͽ� �������� �Ͽ����ϴ�\n\n����� ������� �����ϴ� ���, ���������� ���� ���� �� �ֽ��ϴ�\n\n��ڿ��� ���������� ����� �뺸�Ͽ����ϴ�");
    }
    else if (event.altKey && kc == 9) {
      // Alt + Tab (ȭ����ȯ) : ����Ұ� --> LostFocus ���� ó��
      // EvtLog("22");
      // myalert("������ Alt + Tab �� �̿��Ͽ� ȭ����ȯ�� �Ͽ����ϴ�\n\n���������� ���� ���� �� �ֽ��ϴ�\n\n��ڿ��� �뺸�Ͽ����ϴ�");
    }
    else if (event.altKey && kc == 27) {
      // Alt + Esc (ȭ����ȯ) : ����Ұ� --> LostFocus ���� ó��
      // EvtLog("23");
      // myalert("������ Alt + Esc �� �̿��Ͽ� ȭ����ȯ�� �Ͽ����ϴ�\n\n���������� ���� ���� �� �ֽ��ϴ�\n\n��ڿ��� �뺸�Ͽ����ϴ�");
    }
    // �����׸�
    else if (kc == 91 || kc == 92) {
      // Windows
      Hide();
      EvtLog("51");
      myalert("������ WindowsŰ�� ����Ͻ� �� �����ϴ�\n\n������ ������ ������ ��� ������ �ִ� ���ΰ�ħ�� ��������.");
    }
    else if (kc == 93) {
      // Context menu
      myalert("������ ���ؽ�Ʈ �޴�Ű�� ����Ͻ� �� �����ϴ�\n\n������ ������ ������ ��� ������ �ִ� ���ΰ�ħ�� ��������.");
      event.keyCode = 0;
      return false;
      //EvtLog("52"); // event.keyCode = 0 �� �����ϹǷ� �α����� ���ʿ�
    }
    else if (kc == 112) {
      // F1 (IE ����)
      EvtLog("53");
      Hide();
      myalert("������ F1Ű�� ����Ͻ� �� �����ϴ�\n\n����â�� ��������\n\n������ ������ ������ ��� ������ �ִ� ���ΰ�ħ�� ��������.");
    }
    else if (kc == 114) {
      // F3 (IE �˻�â)
      myalert("������ F3Ű�� ����Ͻ� �� �����ϴ�");
      event.keyCode = 0;
      return false;
      // EvtLog("54"); // event.keyCode = 0 �� �����ϹǷ� �α����� ���ʿ�
    }
    else if (kc == 116) {
      // F5 Key (���ΰ�ħ:����)
      ExamEndYN = "Y"; // CloseUsingX �� �����ϱ� ����
      EvtLog("55");
      Hide();
      myalert("������ ������ ���� ��� F5 �� ������ ����\n\n��ܿ����� �ִ� [���ΰ�ħ] ��ư�� ��������\n\nF5 Ű�� �̿��� ��� ���� ����� ������ ���� �ֽ��ϴ�\n\nȮ���� �ٽ� ������ �����ϼ���");
    }
    // Ctrl(17) or Alt(18) + ��ŸŰ �������
    else if ((event.ctrlKey || event.altKey)) {
      if (kc != 17 && kc != 18) {
        myalert("Ctrl �Ǵ� Alt Ű���� �������� Ű����� ����� �� �����ϴ�.");
        event.keyCode = 0;
        event.cancelBubble = true;
        event.returnValue = false;
        return false;
      }
    }
  } // end of log_option == "Y"
}

document.onkeyup = chkkeyup;
document.onkeydown = chkkeydown;
