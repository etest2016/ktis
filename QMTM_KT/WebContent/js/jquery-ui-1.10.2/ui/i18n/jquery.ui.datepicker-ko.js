/* Korean initialisation for the jQuery calendar extension. */
/* Written by DaeKwon Kang (ncrash.dk@gmail.com), Edited by Genie. */
jQuery(function($){
	$.datepicker.regional['ko'] = {
		closeText: '�ݱ�',
		prevText: '������',
		nextText: '������',
		currentText: '����',
		monthNames: ['1��','2��','3��','4��','5��','6��',
		'7��','8��','9��','10��','11��','12��'],
		monthNamesShort: ['1��','2��','3��','4��','5��','6��',
		'7��','8��','9��','10��','11��','12��'],
		dayNames: ['�Ͽ���','������','ȭ����','������','�����','�ݿ���','�����'],
		dayNamesShort: ['��','��','ȭ','��','��','��','��'],
		dayNamesMin: ['��','��','ȭ','��','��','��','��'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		yearSuffix: '��'};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
});
