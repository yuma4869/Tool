
function AddTable() {
    var table = document.getElementById("create_table");
    var newRow = table.insertRow();

    var name = newRow.insertCell();
    name.innerHTML = current_user + '<input type="hidden" name="name" value="' + current_user + '">';

    var title = newRow.insertCell();
    title.innerHTML = '<input type="text" name="[title][]" id="title">';

    var content = newRow.insertCell();
    content.innerHTML = '<input type="text" name="[content][]" id="content">';

    var time = newRow.insertCell();
    time.innerHTML = '<input type="text" name="[time][]" id="time" onkeyup="timeCheck()">';

    var submit = newRow.insertCell();
    submit.innerHTML = '<a class="delete_button" onclick="DeleteTable()">削除</a>';
}

function DeleteTable() {
    var table = document.getElementById("create_table");
    var lastRowIndex = table.rows.length - 1
    table.deleteRow(lastRowIndex);
}