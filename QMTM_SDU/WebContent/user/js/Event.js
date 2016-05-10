function refresh_onclick()
{
  ExamEndYN = "Y"; // CloseUsingX 를 무시하기 위함

  EvtLog("2"); // 새로고침
  var timeLeft = document.frmData.timeLeft.value;
  top.frames("fraTest").location.replace("etest.jsp?id_exam=" + id_exam + "&userid=" + userid + "&gindex=" + gindex + "&timeLeft=" + timeLeft);
}

function CloseUsingX()
{
  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    // 강제종료(X) Event Log 저장 : 20
    EvtLog("20");
    myalert("시험중 X 버튼을 이용하여 시험화면을 벗어나는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
  }
}

function Resize()
{
  if (log_option == "Y")
  {
    if (isWindowResized) { return; }
    isWindowResized = true;

    // 창크기변경 Event Log 저장 : 11
    Hide();
    EvtLog("11");
    myalert("시험중 창크기를 변경하는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
    ExamEndYN = "Y"; // CloseUsingX 를 무시하기 위함임
    parent.close();
  }
}

function Move()
{
  // frameset 이용으로 적용 불가
}

function WindowMoved()
{
  // 창의 위치 변경여부

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
      // 창위치변경 Event Log 저장 : 12
      Hide();
      EvtLog("12");
      myalert("시험중 창위치를 변경하는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
      ExamEndYN = "Y"; // CloseUsingX 를 무시하기 위함임
      parent.close();
    }
  }
}

function LostFocus()
{
  if (ignoreLostFocus) {     // Refresh, Key-Event, alert 등등
    ignoreLostFocus = false;
    return;
  }

  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    // LostFocus 의 원인
    if (keyCodeTabEsc == 9) { // Alt+Tab
      EvtLog("22");
      myalert("시험중 시험화면을 벗어나는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
      keyCodeTabEsc = 0;
    } else if (keyCodeTabEsc == 27) { // Alt+Esc
      EvtLog("23");
      myalert("시험중 시험화면을 벗어나는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
      keyCodeTabEsc = 0;
    }

    // 포커스이동 Event Log 저장 : 13
    EvtLog("13");
    //myalert("시험중 시험화면을 벗어나는 것은 부정행위로 간주합니다.\n\n상기 사항을 기록하고 운영자에게 통보하였습니다.");
  }
}

function chkkeyup(e)
{
    var kc = event.keyCode;
    if (kc == 9 || kc == 27) { keyCodeTabEsc = kc; } // LostFocus() 에서 이용
}

function chkkeydown(e)
{
  if (log_option == "Y" && ExamEndYN == "N" && document.all.guide.style.display == "none")
  {
    ignoreLostFocus = false;
    var kc = event.keyCode;

    if (kc == 93 || kc == 113 || kc >= 116 && kc <= 123) {
      // myalert("시험중 누르신 키는 사용하실 수 없습니다 ...");
      event.keyCode = 0;
      event.cancelBubble = true;
      event.returnValue = false;
      return false;
    }

    // 경고항목
    if (event.altKey && kc == 115) {
      // Alt + F4 (강제종료)
      ExamEndYN = "Y"; // CloseUsingX 를 무시하기 위함
      Hide();
      AnsSave("F"); // remain-time 저장을 위하여
      EvtLog("21");
      myalert("시험중 Alt + F4 를 이용하여 강제종료 하였습니다\n\n운영자의 허락없이 종료하는 경우, 부정행위로 오해 받을 수 있습니다\n\n운영자에게 강제종료한 사실을 통보하였습니다");
    }
    else if (event.altKey && kc == 9) {
      // Alt + Tab (화면전환) : 제어불가 --> LostFocus 에서 처리
      // EvtLog("22");
      // myalert("시험중 Alt + Tab 를 이용하여 화면전환을 하였습니다\n\n부정행위로 오해 받을 수 있습니다\n\n운영자에게 통보하였습니다");
    }
    else if (event.altKey && kc == 27) {
      // Alt + Esc (화면전환) : 제어불가 --> LostFocus 에서 처리
      // EvtLog("23");
      // myalert("시험중 Alt + Esc 를 이용하여 화면전환을 하였습니다\n\n부정행위로 오해 받을 수 있습니다\n\n운영자에게 통보하였습니다");
    }
    // 주의항목
    else if (kc == 91 || kc == 92) {
      // Windows
      Hide();
      EvtLog("51");
      myalert("시험중 Windows키를 사용하실 수 없습니다\n\n문제가 보이지 않으면 상단 우측에 있는 새로고침을 누르세요.");
    }
    else if (kc == 93) {
      // Context menu
      myalert("시험중 컨텍스트 메뉴키를 사용하실 수 없습니다\n\n문제가 보이지 않으면 상단 우측에 있는 새로고침을 누르세요.");
      event.keyCode = 0;
      return false;
      //EvtLog("52"); // event.keyCode = 0 가 가능하므로 로그저장 불필요
    }
    else if (kc == 112) {
      // F1 (IE 도움말)
      EvtLog("53");
      Hide();
      myalert("시험중 F1키를 사용하실 수 없습니다\n\n도움말창을 닫으세요\n\n문제가 보이지 않으면 상단 우측에 있는 새로고침을 누르세요.");
    }
    else if (kc == 114) {
      // F3 (IE 검색창)
      myalert("시험중 F3키를 사용하실 수 없습니다");
      event.keyCode = 0;
      return false;
      // EvtLog("54"); // event.keyCode = 0 가 가능하므로 로그저장 불필요
    }
    else if (kc == 116) {
      // F5 Key (새로고침:강제)
      ExamEndYN = "Y"; // CloseUsingX 를 무시하기 위함
      EvtLog("55");
      Hide();
      myalert("문제가 보이지 않을 경우 F5 를 누르지 말고\n\n상단우측에 있는 [새로고침] 버튼을 누르세요\n\nF5 키를 이용할 경우 기존 답안이 없어질 수도 있습니다\n\n확인후 다시 시험을 시작하세요");
    }
    // Ctrl(17) or Alt(18) + 기타키 사용제한
    else if ((event.ctrlKey || event.altKey)) {
      if (kc != 17 && kc != 18) {
        myalert("Ctrl 또는 Alt 키와의 복합적인 키기능은 사용할 수 없습니다.");
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
