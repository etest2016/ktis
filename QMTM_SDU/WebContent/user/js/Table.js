// <META name="AUTHOR" content="CheongJH">

function Table_Simple(tbl)
{
  tbl.style.borderTop = 0;
  tbl.style.borderLeft = 0;

  var colTD = tbl.getElementsByTagName("TD");

  for (var i = 0; i < colTD.length; i++)
  {
    if (colTD[i].id != "tdSpace") {
      colTD[i].style.borderBottom = 0;
      colTD[i].style.borderRight = 0;
    }
  }
}
