function submitForm(statusKey) {
    document.getElementById('statusInput').value = statusKey;
    var allTabs = document.querySelectorAll('.nav-pills .nav-link');
    allTabs.forEach(function (el) {
        el.classList.remove('active');
    });
    var clickedTab = document.getElementById(statusKey + '-tab');
    if (clickedTab) {
        clickedTab.classList.add('active');
    }
    document.getElementById('filterForm').submit();
}