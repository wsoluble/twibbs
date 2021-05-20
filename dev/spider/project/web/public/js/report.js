$(document).ready(function() {

	resize_textarea($('#comment-body').get(0));

	$(document).on('click', '#post-submit', function() {
		var method = $(this).data('method');
		var html = $(this).html();
		var target = $('#post-target-id').val();
		var rtype = $('#select-report-type').val();
		var body = $('#comment-body').val();
		if (!target) {
			$('#post-status').html('<span class="ajax-error">通報対象が不正です</span>');
			$('#post-status').show();
			setTimeout(function() {
				$('#post-status').fadeOut('slow');
			},800);
			return false;
		}
		if (body == '') {
			$('#post-status').html('<span class="ajax-error">本文が空です</span>');
			$('#post-status').show();
			setTimeout(function() {
				$('#post-status').fadeOut('slow');
			},800);
			return false;
		}
		if (!rtype) {
			$('#post-status').html('<span class="ajax-error">スパム報告の種類を選択してください</span>');
			$('#post-status').show();
			setTimeout(function() {
				$('#post-status').fadeOut('slow');
			},800);
			return false;
		}
		$(this).html(html + '<i class="fa fa-circle-o-notch" aria-hidden="true"></i>');
		$(this).addClass('spin');
		$(this).prop('disabled', true);
		$.ajax({
			// url: 'http://' + location.hostname + '/ajax/' + method + '_report/add',
			url: '/ajax/' + method + '_report/add',
			type: 'POST',
			dataType: 'html',
			context: this,
			data: {
				'target': target,
				'body': body,
				'rtype': rtype
			},
			success: function(data) {
				var st = $(data).attr('id');
				switch (st) {
					case 'ajax-error':
						$('#post-status').html($(data).html());
						$('#post-status').show();
						setTimeout(function() {
							$('#post-status').fadeOut('slow');
						}, 3000);
						break;

					case 'ajax-successful':
						$('#comments').fadeOut('fast', function () {
							$('#comments').html($(data).html());
							$('#comments .comment .body').each(function () {
								var conv = conv_res_body(twemoji.parse($(this).find('p').html()), false);
								$(this).find('p').html(conv.body);
								if (conv.media != '') {
									$(this).append(conv.media);
								}
							});
							$('#comments').fadeIn('fast');
							$('#post-preview').fadeOut().empty();
						});
						$('#comment-body').val('');
						break;

					default:
						break;
				}
				$('#comment-body').trigger('input');
				$(this).html(html);
				$(this).removeClass('spin');
				$(this).prop('disabled', false);
			},
			error: function(XMLHttpRequest, status, error) {
				console.log(error);
			},
		});
	});

	$(document).on('change', '#select-report-type', function() {
		var target = $('#select-report-type option:selected').data('desc');
		$('.report-desc li').removeClass('current');
		$('#' + target).addClass('current');
	});

});
