@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center py-4">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">Manage Admins</h6>
				</div>
				<div class="col-lg-6 col-5 text-right">
					<a href="<?php echo route('admin.admins') ?>" class="btn btn-neutral"><i class="ni ni-bold-left"></i> Back</a>
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
							<h3 class="mb-0">Create New Admin Here.</h3>
						</div>
					</div>
				</div>
				<div class="card-body">
					<form method="post" action="<?php echo route('admin.admins.add') ?>" class="form-validation">
						<!--!! CSRF FIELD !!-->
						{{ @csrf_field() }}
						<h6 class="heading-small text-muted mb-4">User information</h6>
						<div class="pl-lg-4">
							<div class="row">
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">First name</label>
										<input type="text" class="form-control" name="first_name" required placeholder="First name" value="{{ old('first_name') }}">
										@error('first_name')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>

								</div>
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-last-name">Last name</label>
										<input type="text" id="input-last-name" class="form-control" placeholder="Last name" name="last_name" value="{{ old('last_name') }}">
										@error('last_name')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-username">Email Address</label>
										<input type="email" id="input-username" class="form-control" placeholder="info@example.com" name="email"  value="{{ old('email') }}">
										@error('email')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-email">Phone Number</label>
										<input type="text" id="input-email" class="form-control" placeholder="9988774455" name="phonenumber"  value="{{ old('phonenumber') }}">
										@error('phonenumber')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
						</div>
						<hr class="my-4" />
						<!-- Address -->
						<h6 class="heading-small text-muted mb-4">Settings</h6>
						<div class="pl-lg-4">
							<div class="form-group">
								<label class="form-control-label">Address</label>
								<textarea rows="2" class="form-control" placeholder="Your address" name="address">{{ old('address') }}</textarea>
								@error('address')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="row">
								
								<div class="col-md-6">
									<!-- FILE OR IMAGE UPLOAD. FOLDER PATH SET HERE in data-path AND CHANGE THE data-multiple TO TRUE SEE MAGIC  -->
									<div 
										class="upload-image-section"
										data-type="image"
										data-multiple="false"
										data-path="admins"
										data-resize-medium="350*350"
										data-resize-small="100*100"
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
						                <textarea class="d-none" name="image"><?php echo old('image') ?></textarea>
						                <div class="show-section <?php echo !old('image') ? 'd-none' : "" ?>">
						                	@include('admin.partials.previewFileRender', ['file' => old('image') ])
						                </div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<div class="custom-control">
											<label class="custom-toggle">
												<input type="hidden" name="send_password_email" value="0">
												<input type="checkbox" name="send_password_email" value="1" id="sendPasswordEmail" <?php echo (old('send_password_email') != '0' ? 'checked' : '') ?>>
												<span class="custom-toggle-slider rounded-circle" data-label-off="No" data-label-on="Yes"></span>
											</label>
											<label class="custom-control-label">Send credentials on email ?</label>
										</div>
										@error('send_password_email')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>

									<div class="form-group passwordGroup <?php echo old('send_password_email') != '0' ? 'd-none' : '' ?>">
										<div class="input-group">
											<input type="password" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username with two button addons" aria-describedby="button-addon4" name="password" value="{{ old('password') }}">
											<div class="input-group-append" id="button-addon4">
												<button class="btn btn-outline-primary viewPassword" type="button"><i class="fas fa-eye"></i></button>
												<button class="btn btn-outline-primary regeneratePassword" type="button"><i class="fas fa-redo-alt"></i></button>
											</div>
										</div>
										@error('password')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
										<div class="form-group">
											<small class="text-info">Password must be minimum 8 characters long.<br></small>
											<small class="text-info">Password should contain at least one capital letter (A-Z), one small letter (a-z), one number (0-9) and one special character (!@#$%^&amp;*).</small>
										</div>
									</div>
								</div>
							</div>
						</div>

						<hr class="my-4" />
						<!-- Address -->
						<h6 class="heading-small text-muted mb-4">Permissions</h6>
						<div class="pl-lg-4">
							<div class="form-group">
								<div class="custom-control">
									<label class="custom-toggle">
										<input type="hidden" name="is_admin" value="0">
										<input type="checkbox" name="is_admin" value="1" id="isAdmin" <?php echo old('is_admin') != '0' ? 'checked' : '' ?>>
										<span class="custom-toggle-slider rounded-circle" data-label-off="No" data-label-on="Yes"></span>
									</label>
									<label class="custom-control-label">User is a super admin ?</label>
								</div>
								@error('is_admin')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="table-responsive <?php echo old('is_admin') != '0' ? 'd-none' : '' ?>" id="permissionTable">
								<div class="col-md-12 text-right">
									@error('permissions')
									    <small class="text-danger float-left">{{ $message }}</small>
									@enderror
									<a 
										href="javascript:;"
										class="mr-2 text-default" 
										onclick="$('#permissionTable input[type=checkbox]').prop('checked', true)" 
									>
										<i class="fas fa-check text-info"></i> Select All
									</a>
									<a
										href="javascript:;"
										class="text-default"
										onclick="$('#permissionTable input[type=checkbox]').prop('checked', false)" 
									>
										<i class="fas fa-times text-danger"></i> Deselect All
									</a>
								</div>
								<table class="table align-items-center table-border">
									<thead class="thead-light">
										<tr>
											<th>Modules</th>
											<th>Listing</th>
											<th>Create</th>
											<th>Update</th>
											<th>Delete</th>
										</tr>
									</thead>
									<tbody>
										<?php $adminPermissions = old('permissions'); ?>
										<?php foreach($permissions as $p): ?>
										<tr>
											<td>
												<span class="badge badge-dot mr-4">
													<i class="bg-warning"></i>
													<span class="status"><?php echo $p['title'] ?></span>
												</span>
												
											</td>
											<td>
												<label class="custom-toggle">
													<input type="checkbox" name="permissions[<?php echo $p['id'] ?>][]" value="listing" <?php echo (isset($adminPermissions[$p['id']]) && in_array('listing', $adminPermissions[$p['id']]) ? 'checked' : '') ?>>
													<span class="custom-toggle-slider rounded-circle"></span>
												</label>
											</td>
											<td>
												<label class="custom-toggle">
												  <input type="checkbox"  name="permissions[<?php echo $p['id'] ?>][]" value="create" <?php echo (isset($adminPermissions[$p['id']]) && in_array('create', $adminPermissions[$p['id']]) ? 'checked' : '') ?>>
												  <span class="custom-toggle-slider rounded-circle"></span>
												</label>
											</td>
											<td>
												<label class="custom-toggle">
											  		<input type="checkbox"  name="permissions[<?php echo $p['id'] ?>][]" value="update" <?php echo (isset($adminPermissions[$p['id']]) && in_array('update', $adminPermissions[$p['id']]) ? 'checked' : '') ?>>
													<span class="custom-toggle-slider rounded-circle"></span>
												</label>
											</td>
											<td>
												<label class="custom-toggle">
												  	<input type="checkbox"  name="permissions[<?php echo $p['id'] ?>][]" value="delete" <?php echo (isset($adminPermissions[$p['id']]) && in_array('delete', $adminPermissions[$p['id']]) ? 'checked' : '') ?>>
												  	<span class="custom-toggle-slider rounded-circle"></span>
												</label>
											</td>
										</tr>
										<?php endforeach; ?>
									</tbody>
								</table>
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