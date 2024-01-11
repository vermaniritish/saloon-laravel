let order = new Vue({
    el: '#order',
    data: {
        mounting: true,
        subtotal: 0,
        discount: 0,
        taxPercentage: parseFloat(document.getElementById('taxPercentageInput').value),
        selectedProducts: [], 
        selectedCouponId: '',
        tax: 0,
        totalAmount: 0,
        manualAddress: 0,
        productsData: [],
        customerAddresses: [],
        selectedCustomer: null,
        selectedAddress: null,
        loading: false,
        url: ''
    },
    mounted: function() {
        this.mounting = false;
        this.initBasics();
        document.getElementById('order-form').classList.remove('d-none');
        this.initBasics
    },
    methods: {
        initEditValues: function () {
            if ($('#edit-form').length > 0) {
                let data = JSON.parse($('#edit-form').text());
                this.url = admin_url + '/order/' + data.id + '/edit';
                this.subtotal = data.subtotal;
                this.discount = data.discount;
                this.manualAddress = data.manual_address ? true : false;
                this.notifiedActionId = data.notified_action_id ? data.notified_action_id.map(item => item.id) : [];
                this.selectedPrimeMover = data.prime_mover_name ? data.prime_mover_name : '';
            }
            else {
                this.url = admin_url + '/order/add';
            };
        },
        initBasics: function () {
            setTimeout(function () {
                $('select').removeClass('no-selectpicker');
                initSelectpicker('select');
            }, 50);
        },
        updateTotal: function () {
            this.updateProductsData();
            this.calculateTotal();
        },
        updateProductsData: function () {
            for (let productId of this.selectedProducts) {
                let price = parseFloat(document.querySelector(`select[name="product_id[]"] [value="${productId}"]`).getAttribute('data-product-price'));
                let existingProductIndex = this.productsData.findIndex(product => product.id === productId);
                if (existingProductIndex !== -1) {
                } else {
                    let productData = {
                        id: productId,
                        title: document.querySelector(`select[name="product_id[]"] [value="${productId}"]`).textContent,
                        rate: price,
                        quantity: 1,
                    };
                    this.productsData.push(productData);
                    this.subtotal += price;
                }
            }
        },
        calculateTotal: function () {
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
            document.getElementById('tax').textContent = this.tax.toFixed(2);
            document.getElementById('total_amount').textContent = this.totalAmount.toFixed(2);

            document.querySelector('input[name="subtotal"]').value = this.subtotal.toFixed(2);
            document.querySelector('input[name="discount"]').value = this.discount.toFixed(2);
            document.querySelector('input[name="tax"]').value = this.tax.toFixed(2);
            document.querySelector('input[name="total_amount"]').value = this.totalAmount.toFixed(2);
        },
        updateQuantity: function (index) {
            this.productsData[index].quantity = parseInt(this.productsData[index].quantity);
            this.calculateSubtotal();
            this.calculateTotal();
            console.log(this.productsData);
        },
        calculateSubtotal: function () {
            this.subtotal = 0;
            for (let product of this.productsData) {
                this.subtotal += product.rate * product.quantity;
            }
            return this.subtotal;
        },
        updateAddresses: async function() {
            customerId = this.selectedCustomer
            let response = await fetch(admin_url + "/order/getAddress/customer/" + customerId);
            response = await response.json();
            if(response && response.status)
            {
                this.customerAddresses = response.addresses;
                setTimeout(function () {
                    $("#address-form select").selectpicker("refresh");
                }, 50);
            } else{
                set_notification('error', response.message);
            }
        },
        submitForm: async function() {
            let formData = new FormData(document.getElementById('order-form'));
            let productIdsAndQuantities = this.productsData.map(product => ({ id: product.id, quantity: product.quantity }));
            formData.append('productsData', JSON.stringify(productIdsAndQuantities));
            let response = await fetch(this.url, {
                method: 'POST',
                body: formData,
            });
            response = await response.json();
            if(response && response.status)
            {
                setTimeout(function () {
                    window.location.href = (admin_url + '/order/' + response.id + '/view');
                }, 200)
            }else{
                set_notification('error', response.message);
                
            }
        },
        
    },
    watch: {
        selectedCustomer: function (newCustomerId) {
            this.updateAddresses();
        },
    },
});