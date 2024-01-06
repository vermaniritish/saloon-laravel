@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center py-4">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">Manage Orders</h6>
				</div>
				<div class="col-lg-6 col-5 text-right">
					<a href="<?php echo route('admin.orders') ?>" class="btn btn-neutral"><i class="ni ni-bold-left"></i> Back</a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Page content -->
<div class="container-fluid mt--6">
	<div>
		<div class="row">
			<div class="col-xl-12 order-xl-1">
				<div class="card">
					<!--!! FLAST MESSAGES !!-->
					@include('admin.partials.flash_messages')
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col-8">
								<h3 class="mb-0">Create New Order Here.</h3>
							</div>
						</div>
					</div>
					<div class="card-body">
						<div id="order">
							<p v-if="mounting" class="text-center big" style="padding: 15%"><i style="font-size: 30px" class="fa fa-spin fa-spinner"></i></p>
							<form id="order-form" method="post" action="<?php echo route('admin.orders.add') ?>" class="form-validation d-none">
								<!--!! CSRF FIELD !!-->
								{{ @csrf_field() }}
								<h6 class="heading-small text-muted mb-4">Order information</h6>
								<div class="pl-lg-4">			
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-control-label">Customers</label>
												<select class="form-control no-selectpicker" name="customer_id" required>
													<option value="">Select</option>
													<?php 
														foreach($users as $s): 
														$content =  $s->first_name . " " . $s->last_name . "<small class='badge badge-".($s->status ? "success" : "danger")."'>".($s->status ? "Active" : "Inactive")."</small>";
													?>
													<option 
														value="<?php echo $s->id ?>" 
														<?php echo old('customer_id') == $s->id  ? 'selected' : '' ?>
														data-content="<?php echo $content ?>"
													>
														<?php echo $s->name; ?>		
													</option>
													<?php endforeach; ?>
												</select>
												@error('customer_id')
												<small class="text-danger">{{ $message }}</small>
												@enderror
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-control-label" for="input-first-name">Products</label>
												<select v-model="selectedProducts" v-on:change="updateTotal" class="form-control no-selectpicker" name="product_id[]" multiple required>
													@foreach($productCategories as $category)
														<optgroup label="{{ $category->title }}">
															@foreach($category->products as $product)
																<option 
																	value="{{ $product->id }}"
																	data-product-price="{{ $product->price }}" 
																	<?php echo old('product_id') && in_array($product->id, old('product_id'))  ? 'selected' : '' ?>
																>
																	{{ $product->title }}    
																</option>
															@endforeach
														</optgroup>
													@endforeach
												</select>
												@error('product_id')
													<small class="text-danger">{{ $message }}</small>
												@enderror
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-control-label" for="input-first-name">Booking Date</label>
												<input class="form-control" type="date" name="booking_date" required placeholder="Coupon End Date" value="{{ old('booking_date') }}">
												@error('booking_date')
													<small class="text-danger">{{ $message }}</small>
												@enderror
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-control-label" for="input-first-name">Booking Time</label>
												<input class="form-control" type="time" name="booking_time" required placeholder="Coupon End Date" value="{{ old('booking_time') }}">
												@error('booking_time')
													<small class="text-danger">{{ $message }}</small>
												@enderror
											</div>
										</div>
									</div>
									<div class="row">
									<div class="col-md-6" id="contractor">
										<div class="form-group">
											<div class="custom-control p-0">
												<label class="custom-toggle">
													<input type="checkbox" v-model="manualAddress" name="manual_address" value="1">
													<span class="custom-toggle-slider rounded-circle" data-label-off="No"
														data-label-on="Yes"></span>
												</label>
												<label class="custom-control-label">Manual Address ?</label>
											</div>
										</div>
									</div>
									</div>
									<div v-if="manualAddress" class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-control-label" for="input-manual-address">Address</label>
												<input type="text" class="form-control" name="address" :required ="manualAddress">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-control-label" for="input-manual-address">State</label>
												<input type="text" class="form-control" name="state" :required ="manualAddress">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-control-label" for="input-manual-address">City</label>
												<input type="text" class="form-control" name="city" :required ="manualAddress">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-control-label" for="input-manual-address">Area</label>
												<input type="text" class="form-control" name="area" :required ="manualAddress">
											</div>
										</div>
									</div>
									<div class="row">
										<div v-if="!manualAddress" class="col-md-6">
											<div class="form-group">
												<label class="form-control-label" for="input-first-name">Addresses</label>
												<select class="form-control no-selectpicker" name="address_id" :required ="manualAddress">
													<option value="">Select</option>
													<?php foreach($address as $c): ?>
														<?php
															$addressLabel = implode('-', [
																$c->address,
																$c->state,
																$c->city,
																$c->area,
															]);
														?>
														<option 
															value="<?php echo $c->id ?>"
															<?php echo old('address_id') && in_array($c->id, old('address_id'))  ? 'selected' : '' ?>
														>
															<?php echo $addressLabel ?>	
														</option>
													<?php endforeach; ?>
												</select>
												@error('address_id')
													<small class="text-danger">{{ $message }}</small>
												@enderror
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-control-label" for="input-first-name">Payment Type</label>
												<select class="form-control no-selectpicker" name="payment_type" required>
													<option value="">Select</option>
													<?php foreach($paymentType as $c): ?>
														<option 
															value="<?php echo $c ?>"
															<?php echo old('payment_type') && in_array($c, old('payment_type'))  ? 'selected' : '' ?>
														>
															<?php echo $c ?>	
														</option>
													<?php endforeach; ?>
												</select>
												@error('payment_type')
													<small class="text-danger">{{ $message }}</small>
												@enderror
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
										<div class="form-group">
												<label class="form-control-label">Coupon Code</label>
												<select class="form-control no-selectpicker"
												v-model="selectedCouponId" 
												v-on:change="updateTotal" 
												name="coupon_code_id" 
												>
													<option value="">Select</option>
													<?php 
														foreach($coupons as $coupon): 
													?>
													<option 
														data-coupon-is-percentage="<?php echo $coupon->is_percentage ?>" 
														data-coupon-amount="<?php echo $coupon->amount ?>" 
														value="<?php echo $coupon->id ?>" 
														<?php echo old('coupon_code_id') == $coupon->id  ? 'selected' : '' ?>
													>	
													<?php echo $coupon->title ?>
													</option>
													<?php endforeach; ?>
												</select>
												@error('coupon_code_id')
												<small class="text-danger">{{ $message }}</small>
												@enderror
											</div>
										</div>
									</div>
									<hr class="my-4" />
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-control-label">Subtotal</label>
												<input type="hidden" name="subtotal" v-model="subtotal">
												<span id="subtotal" name="subtotal" class="form-control-static">0.00</span>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-control-label">Discount</label>
												<input type="hidden" name="discount" v-model="discount">
												<span id="discount" class="form-control-static">0.00</span>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
											<input type="hidden" id="taxPercentageInput" value="{{ $tax_percentage }}">
											<input type="hidden" name="tax" v-model="tax">
												<label class="form-control-label">Tax And Charges ({{ $tax_percentage }}%)</label>
												<span id="tax" name="tax" class="form-control-static">0.00</span>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<input type="hidden" name="total_amount" v-model="totalAmount">
												<label class="form-control-label">Total Amount</label>
												<span id="total_amount" name="total_amount" class="form-control-static">0.00</span>
											</div>
										</div>
									</div>
									</div>
								<hr class="my-4" />
								<button href="#" class="btn btn-sm py-2 px-3 btn-primary float-right">
									<i class="fa fa-save"></i> Submit
								</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection