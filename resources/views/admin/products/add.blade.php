@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center py-4">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">Manage Products</h6>
				</div>
				<div class="col-lg-6 col-5 text-right">
					<a href="<?php echo route('admin.products') ?>" class="btn btn-neutral"><i class="ni ni-bold-left"></i> Back</a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Page content -->
<div class="container-fluid mt--6">
	<div class="row">
		<div class="col-xl-12 order-xl-1">
			<div class="card">
				<!--!! FLAST MESSAGES !!-->
				@include('admin.partials.flash_messages')
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col-8">
							<h3 class="mb-0">Create New Product Here.</h3>
						</div>
					</div>
				</div>
				<div class="card-body">
					<form method="post" action="<?php echo route('admin.products.add') ?>" class="form-validation">
						<!--!! CSRF FIELD !!-->
						{{ @csrf_field() }}
						<h6 class="heading-small text-muted mb-4">Product information</h6>
						<div class="pl-lg-4">
							<div class="form-group">
								<label class="form-control-label">Customers</label>
								<select class="form-control" name="user_id" required>
							      	<option value="">Select</option>
							      	<?php 
							      		foreach($users as $s): 
							      		$content =  $s->first_name . " " . $s->last_name . "<small class='badge badge-".($s->status ? "success" : "danger")."'>".($s->status ? "Active" : "Inactive")."</small>";
							      	?>

							      		<option 
							      			value="<?php echo $s->id ?>" 
							      			<?php echo old('user_id') == $s->id  ? 'selected' : '' ?>
							      			data-content="<?php echo $content ?>"
							      		>
							      			<?php echo $s->name; ?>		
							      		</option>
							  		<?php endforeach; ?>
							    </select>
							   	@error('user_id')
							    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="form-group">
								<label class="form-control-label" for="input-first-name">Category</label>
								<select class="form-control" name="category[]" multiple required>
							      	<option value="">Select</option>
							      	<?php foreach($categories as $c): ?>
							      		<option 
							      			value="<?php echo $c->id ?>"
							      			<?php echo old('category') && in_array($c->id, old('category'))  ? 'selected' : '' ?>
							      		>
							      			<?php echo $c->title ?>	
							      		</option>
							  		<?php endforeach; ?>
							    </select>
								@error('category')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="form-group">
								<label class="form-control-label" for="input-first-name">Title</label>
								<input type="text" class="form-control" name="title" placeholder="Title" required value="{{ old('title') }}">
								@error('title')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="row">
								<div class="col-lg-12">
									<div class="form-group">
										<label class="form-control-label">Description</label>
										<textarea rows="2" id="editor1" class="form-control" placeholder="Description" required name="description">{{ old('description') }}</textarea>
										@error('description')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Price</label>
										<input type="number" class="form-control" name="price" placeholder="Price" required value="{{ old('price') }}">
										@error('price')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Sale Price</label>
										<div class="custom-control inline float-right">
											<label class="custom-toggle">
												<input 
													type="checkbox"
													<?php echo (old('sale_price') != '' ? 'checked' : '') ?>
													onchange="$(this).is(':checked') ? $(this).parents('.custom-control').next('input').attr('readonly', false) : $(this).parents('.custom-control').next('input').attr('readonly', true)"
												>
												<span class="custom-toggle-slider rounded-circle" data-label-off="No" data-label-on="Yes"></span>
											</label>
										</div>
										<input type="number" class="form-control" name="sale_price" <?php echo (old('status') == '' ? 'readonly' : '') ?> placeholder="Sale Price" value="{{ old('sale_price') }}">
										@error('sale_price')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Location</label>
										<input type="search" class="form-control" id="google-address" autocomplete="off"  name="address" placeholder="Address" required value="{{ old('address') }}">
										@error('address')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Lattitude</label>
										<input type="text" class="form-control" id="google-lat" name="lat" placeholder="Address" required value="{{ old('lat') }}" readonly="">
										@error('lat')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Longitude</label>
										<input type="text" class="form-control" id="google-lng" name="lng" placeholder="Address" required value="{{ old('lng') }}" readonly="">
										@error('lng')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
						</div>
						<hr class="my-4" />
						<!-- Address -->
						<h6 class="heading-small text-muted mb-4">Publish Information</h6>
						<div class="pl-lg-4">
							<div class="row">
								<div class="col-lg-6">
									<div class="form-group">
										<!-- FILE OR IMAGE UPLOAD. FOLDER PATH SET HERE in data-path AND CHANGE THE data-multiple TO TRUE SEE MAGIC  -->
										<div 
											class="upload-image-section"
											data-type="image"
											data-multiple="true"
											data-path="products"
											data-resize-large="802*574"
											data-resize-medium="415*296"
											data-resize-small="110*85"

										>
											<div class="upload-section">
												<div class="button-ref mb-3">
													<button class="btn btn-icon btn-primary btn-lg" type="button">
										                <span class="btn-inner--icon"><i class="fas fa-upload"></i></span>
										                <span class="btn-inner--text">Upload Image</span>
									              	</button>
									            </div>
									            <!-- PROGRESS BAR -->
												<div class="progress d-none">
								                  <div class="progress-bar bg-default" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
								                </div>
								            </div>
							                <!-- INPUT WITH FILE URL -->
							                <textarea class="d-none" required name="image"><?php echo old('image') ?></textarea>
							                <div class="show-section <?php echo !old('image') ? 'd-none' : "" ?>">
							                	@include('admin.partials.previewFileRender', ['file' => old('image') ])
							                </div>
										</div>
										@error('image')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-lg-6">
									<div class="form-group">
										<div class="custom-control">
											<label class="custom-toggle">
												<input type="hidden" name="status" value="0">
												<input type="checkbox" name="status" value="1" <?php echo (old('status') != '0' ? 'checked' : '') ?>>
												<span class="custom-toggle-slider rounded-circle" data-label-off="No" data-label-on="Yes"></span>
											</label>
											<label class="custom-control-label">Do you want to publish this product ?</label>
										</div>
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
@endsection