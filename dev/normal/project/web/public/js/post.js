$(document).ready(function() {

	resize_textarea($('#comment-body').get(0));

	$('#tag-text').autocomplete({
		source: function(req, res) {
			$.ajax({
				url: 'http://' + location.hostname + '/ajax/tag',
				type: 'POST',
				dataType: 'json',
				data: {
					'q': req.term
				},
				success: function(data) {
					res(data);
				},
				error: function(XMLHttpRequest, status, error) {
					console.log(error.message);
				},
			});
		},
		autoFocus: false,
		delay: 500,
		minLength: 1
	});

	$(document).on('keydown keyup change', '#title-text', function(e) {
		if(e.which == 13) {
			return false;
		}
		var arr = stringToArray($(this).val());
		var left  = TITLE_LENGTH - arr.length;
		if (left < 0) {
			var text = arr.slice(0, TITLE_LENGTH).join('');
			$(this).val(text);
			left = 0;
		}
		$('#title-count').html(left);
	});

	$(document).on('keydown keyup change', '#tag-text', function(e) {
		var arr = stringToArray($(this).val());
		var left  = TAG_LENGTH - arr.length;
		if (left < 0) {
			var text = arr.slice(0, TAG_LENGTH).join('');
			$(this).val(text);
			left = 0;
		}
		$('#tag-count').html(left);
		if(e.which == 13) {
			return false;
		}
	});

	$(document).on('click', '#tag-add', function() {
		add_tag($('#tag-text').val());
		$('#tag-text').focus();
	});

	$(document).on('click', '.tag-delete', function() {
		$(this).parent().remove();
	});

	$(document).on('change', '#category-select', function() {
		var target = $(this).val();
		$('.category-rule').hide();
		$('#category-rule-' + target).show();
	});

});

function add_tag(tag) {
	var count = $('.tag-group .tag').length;
	var dup = false;
	if (tag == '') {
		set_status('#tag-status', '<span class="error">タグを入力してください。</span>');
		return false;
	}
	$('#tags input[name="tags[]"]').each(function() {
		if ($(this).val() == tag) {
			set_status('#tag-status', '<span class="error">同じタグがあります。</span>');
			dup = true;
		}
	});
	if (dup == true) {
		return false;
	}
	if (count >= TAG_MAX) {
		set_status('#tag-status', '<span class="error">タグは10個までです。</span>');
		return false;
	}
	var html = '<div class="tag">' +
	'<input type="hidden" name="tags[]" value="' + tag + '" readonly>' +
	'<span class="tag-word">' + tag + '</span>' +
	'<button class="tag-delete" type="button"><i class="fa fa-times" aria-hidden="true"></i></button>' +
	'</div>';
	$('#tags').append(html)
	$('#tag-text').val('');
	$('#tag-count').html(TAG_LENGTH);
}

function set_status(selector, html) {
	$(selector).html(html);
	$(selector).show();
	setTimeout(function() {
		$(selector).fadeOut('slow');
	},800);
}
