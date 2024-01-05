let order = new Vue({
    el: '#order',
    data: {
        mounting: true,
        subtotal: 0,
        discount: 0,
        taxPercentage:  this.taxPercentage = parseFloat(document.getElementById('taxPercentageInput').value),
        selectedProducts: [], 
        selectedCouponId: '',
        tax: 0,
        totalAmount: 0,
        manualAddress: 0,
    },
    mounted: function() {
        this.mounting = false;
        this.initBasics();
        document.getElementById('order-form').classList.remove('d-none');
    },
    methods: {
        initBasics: function () {
            setTimeout(function () {
                $('select').removeClass('no-selectpicker');
                initSelectpicker('select');
            }, 50);
        },
        updateTotal: function() {
            this.subtotal = 0;
            for (let productId of this.selectedProducts) {
                let price = parseFloat(document.querySelector(`select[name="product_id[]"] [value="${productId}"]`).getAttribute('data-product-price'));
                this.subtotal += price;
            }
            if (this.selectedCouponId) {
                let isPercentage = parseFloat(document.querySelector(`select[name="coupon_code_id"] [value="${this.selectedCouponId}"]`).getAttribute('data-coupon-is-percentage'));
                let amount = parseFloat(document.querySelector(`select[name="coupon_code_id"] [value="${this.selectedCouponId}"]`).getAttribute('data-coupon-amount'));
                if (isPercentage) {
                    this.discount = (amount / 100) * this.subtotal;
                } else {
                    this.discount = amount;
                }
            }
            this.tax = (this.subtotal - this.discount) * (this.taxPercentage / 100);
            this.totalAmount = this.subtotal - this.discount + this.tax;
            document.getElementById('subtotal').textContent = this.subtotal.toFixed(2);
            document.getElementById('discount').textContent = this.discount.toFixed(2);
            document.getElementById('tax').textContent = (this.tax).toFixed(2);
            document.getElementById('total_amount').textContent = this.totalAmount.toFixed(2);
            document.querySelector('input[name="subtotal"]').value = this.subtotal.toFixed(2);
            document.querySelector('input[name="discount"]').value = this.discount.toFixed(2);
            document.querySelector('input[name="tax"]').value = this.tax.toFixed(2);
            document.querySelector('input[name="total_amount"]').value = this.totalAmount.toFixed(2);
        },
    }
});