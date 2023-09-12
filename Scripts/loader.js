function showLoader() {
    var parentDocument = window.parent.document;

    // Access the loader div using the unique CSS class
    var loader = document.getElementById('<%= Master.FindControl("loaderDiv").ClientID %>');

    var loader1 = parentDocument.querySelector('.my-loader');
    loader1.style.display = "block";
    var loader2 = document.getElementById('loader');
    var loader3 = document.querySelector('.my-loader');

    if (loader) {
        loader.style.display = "block";
    }
}

function hideLoader() {
    var loader = document.getElementById('loader');
    var loader = document.querySelector('.my-loader');

    if (loader) {
        loader.style.display = "none";
    }
}