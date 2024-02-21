async function switch_diary_page_action(url, that) {
    var flag = $(that).data('value');
    var currentStatus = $('#Currentstatus').val();
    if (flag.toLowerCase() === currentStatus) {
        var text = $(that).closest('.dropdown').find('.btn').text().toLowerCase();
        set_notification('error', 'Cannot change status to ' + text + ' again.');
        return;
    }
    var statusStyles = await getStatuses();
    $.ajax({
        url: url,
        type: 'post',
        data: {
            flag: flag,
            _token: csrf_token()
        },
        success: function (resp) {
            if ($(that).data('value') && resp.status === 'success') {
                var buttonText = $(that).text();
                var statusData = statusStyles[flag];
                var buttonStyle = statusData.styles || 'background-color: #ffffff; color: #000000;';
                $(that).closest('.dropdown').find('.btn').removeClass().addClass('btn btn-sm dropdown-toggle').attr('style', buttonStyle).text(buttonText);
                set_notification('success', 'Order status updated successfully.');
            }
        }
    })
}
function getStatuses() {
    return $.ajax({
        url: admin_url +'/order/getStatus',
        method: 'GET',
    });
}

function enableEdit(id) {
    document.getElementById(id).querySelector('.edit-icon').style.display = 'none';
    document.getElementById(id).querySelector('.fill-text').style.display = 'none';
    document.getElementById(id).querySelector('.edit').classList.remove('d-none');
}

async function saveEdit(id, fieldName, orderId) {
    let newValue = document.getElementById(id).querySelector('input').value;
    try {
        const response = await fetch(admin_url + '/order/'+ orderId+'/updateField', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': csrf_token()
            },
            body: JSON.stringify({
                fieldName: fieldName,
                value: newValue
            })
        });
        const data = await response.json();
        if (response.ok && data.status === 'success') {
            document.getElementById(id).querySelector('.fill-text').innerHTML = newValue + ' <i class="fas fa-pencil text-primary edit-icon" onclick="enableEdit(\'' + id + '\')"></i>';
            document.getElementById(id).querySelector('.fill-text').style.display = 'inline-block';
            document.getElementById(id).querySelector('.edit').classList.add('d-none');
            set_notification('success', fieldName + 'updated successfully.');
        } else {
            set_notification('error', 'Failed to update field.');
        }
    } catch (error) {
        console.error('Error:', error);
        set_notification('error', 'An error occurred while updating the field.');
    }
}

