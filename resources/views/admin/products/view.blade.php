<?php use App\Models\Admin\Settings; ?>
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
						<a href="<?php echo route('admin.products') ?>" class="btn text-white"><i class="fa fa-arrow-left"></i> Back</a>
						<a href="<?php echo Settings::get('website_url') . '/product/' . $product->slug ?>" class="btn btn-neutral" target="_blank"><i class="fa fa-eye"></i> View Product</a>
						<div class="dropdown" data-toggle="tooltip" data-title="More Actions">
							<a class="btn btn-neutral" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="fas fa-ellipsis-v"></i>
							</a>
							<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
								<a class="dropdown-item" href="<?php echo route('admin.products.edit', ['id' => $product->id]) ?>">
									<i class="fas fa-pencil-alt text-info"></i>
									<span class="status">Edit</span>
								</a>
								<div class="dropdown-divider"></div>
								<a 
									class="dropdown-item _delete" 
									href="javascript:;"
									data-link="<?php echo route('admin.products.delete', ['id' => $product->id]) ?>"
								>
									<i class="fas fa-times text-danger"></i>
									<span class="status text-danger">Delete</span>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Page content -->
	<div class="container-fluid mt--6">
		<div class="row">
			<div class="col-xl-8 order-xl-1">
				<div class="card">
					<!--!! FLAST MESSAGES !!-->
					@include('admin.partials.flash_messages')
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col-8">
								<h3 class="mb-0">Product Information</h3>
							</div>
						</div>
					</div>
					<div class="table-responsive">
						<!-- Projects table -->
						<table class="table align-items-center table-flush view-table">
							<tbody>
								<tr>
									<th>Id</th>
									<td><?php echo $product->id ?></td>
								</tr>
								<tr>
									<th>Title</th>
									<td><?php echo $product->title ?></td>
								</tr>
								<tr>
									<th>Customer</th>
									<td>
										<?php if($product->user_id): ?>
										<a href="<?php echo route('admin.users.view', ['id' => $product->user_id]) ?>"><?php echo $product->users ? $product->users->first_name . ' ' . $product->users->last_name : "" ?></a>
										<?php endif; ?>
									</td>
								</tr>
								<tr>

									<th>Categories</th>
									<td>
										<?php 
										if(isset($product->categories) && $product->categories ): 
											foreach ($product->categories as $key => $pc):
												echo '<span class="badge badge-warning">'.$pc['title'].'</span> ';
											endforeach;
										endif; 
										?>
											
										</td>
								</tr>
								<tr>
									<th>Brands</th>
									<td>
										<?php 
										if(isset($product->brands) && $product->brands ): 
											foreach ($product->brands as $key => $pc):
												echo '<span class="badge badge-warning">'.$pc['title'].'</span> ';
											endforeach;
										endif; 
										?>	
									</td>
								</tr>
								<tr>
									<th>Duration of Service</th>
									<td>
										<?php
										if (isset($product->service_hours) && $product->service_hours > 0) {
											echo $product->service_hours . ':' . $product->service_minutes;
										} else {
											echo 'Not specified';
										}
										?>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<h2>Description</h2>
										<?php echo $product->description ?>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="card">
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col">
								<h3 class="mb-0">Address Information</h3>
							</div>
						</div>
					</div>
					<div class="table-responsive">
						<!-- Projects table -->
						<table class="table align-items-center table-flush view-table">
							<tbody>
								<tr>
									<th scope="row">
										Address
									</th>
									<td>
										<?php if($product->address): ?>
										<a href="https://www.google.com/maps/place/<?php echo urlencode($product->address) . ($product->lat && $product->lng ? '/@'.$product->lat.','.$product->lng.',14z' : '') ?>" target="_blank"><?php echo $product->address ?></a>
										<?php endif; ?>
									</td>
								</tr>
								<tr>
									<th scope="row">
										Lattitude
									</th>
									<td>
										<?php echo $product->lat ?>
									</td>
								</tr>
								<tr>
									<th scope="row">
										Logitude
									</th>
									<td>
										<?php echo $product->lng ?>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-xl-4 order-xl-1">
				<?php if($product->image): ?>
				<div class="card">
					<div class="card-header">
						@include('admin.partials.viewImage', ['files' => $product->getResizeImagesAttribute()])
				    </div>
				</div>
				<?php endif; ?>
				<div class="card">
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col">
								<h3 class="mb-0">Other Information</h3>
							</div>
						</div>
					</div>
					<div class="table-responsive">
						<!-- Projects table -->
						<table class="table align-items-center table-flush view-table">
							<tbody>
								<tr>
									<th scope="row">
										Status
									</th>
									<td>
										<?php echo $product->status ? '<span class="badge badge-success">Published</span>' : '<span class="badge badge-danger">Unpublished</span>' ?>
									</td>
								</tr>
								<tr>
									<th scope="row">
										Created By
									</th>
									<td>
										<?php if(isset($product->owner) && $product->owner): ?>
											<a href="<?php echo route('admin.users.view', ['id' => $product->user_id]) ?>"><?php echo $product->owner->name; ?></a>
										<?php else: ?>
											Shop Owner
										<?php endif; ?>
									</td>
								</tr>
								<tr>
									<th scope="row">
										Created On
									</th>
									<td>
										<?php echo _dt($product->created) ?>
									</td>
								</tr>
								<tr>
									<th scope="row">
										Last Modified
									</th>
									<td>
										<?php echo _dt($product->modified) ?>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
@endsection