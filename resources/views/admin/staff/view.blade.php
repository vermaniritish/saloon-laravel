@extends('layouts.adminlayout')
@section('content')
	<div class="header bg-primary pb-6">
		<div class="container-fluid">
			<div class="header-body">
				<div class="row align-items-center py-4">
					<div class="col-lg-6 col-7">
						<h6 class="h2 text-white d-inline-block mb-0">Manage Pages</h6>
					</div>
					<div class="col-lg-6 col-5 text-right">
						<a href="<?php echo route('admin.staff') ?>" class="btn btn-neutral"><i class="fa fa-arrow-left"></i> Back</a>
						<a href="#" class="btn btn-neutral" target="_blank"><i class="fa fa-eye"></i> View Page</a>
						<?php if(Permissions::hasPermission('brands', 'update') || Permissions::hasPermission('brands', 'delete')): ?>
							<div class="dropdown" data-toggle="tooltip" data-title="More Actions">
								<a class="btn btn-neutral" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<i class="fas fa-ellipsis-v"></i>
								</a>
								<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
									<?php if(Permissions::hasPermission('brands', 'update')): ?>
										<a class="dropdown-item" href="<?php echo route('admin.staff.edit', ['id' => $page->id]) ?>">
											<i class="fas fa-pencil-alt text-info"></i>
											<span class="status">Edit</span>
										</a>
										<?php endif; ?>
									<?php if(Permissions::hasPermission('brands', 'delete')): ?>
										<div class="dropdown-divider"></div>
										<a 
											class="dropdown-item _delete" 
											href="javascript:;"
											data-link="<?php echo route('admin.staff.delete', ['id' => $page->id]) ?>"
										>
											<i class="fas fa-times text-danger"></i>
											<span class="status text-danger">Delete</span>
										</a>
									<?php endif; ?>
								</div>
							</div>
						<?php endif; ?>
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
								<h3 class="mb-0">Staff Information</h3>
							</div>
						</div>
					</div>
					<div class="table-responsive">
						<!-- Projects table -->
						<table class="table align-items-center table-flush">
							<tbody>
								<tr>
									<th>Id</th>
									<td><?php echo $page->id ?></td>
								</tr>
								<tr>
									<th>Staff Name</th>
									<td><?php echo $page->first_name. ' ' .$page->last_name ?></td>
								</tr>
								<tr>
									<th>Phone Number</th>
									<td><?php echo $page->phone_number ?></td>
								</tr>
								<tr>
									<th>Email</th>
									<td><?php echo $page->email ?></td>
								</tr>
								<tr>
									<th>Aadhar Card Number</th>
									<td><?php echo $page->aadhar_card_number ?></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="card">
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col">
								<h3 class="mb-0">Orders Assigned</h3>
							</div>
						</div>
					</div>
					<div class="table-responsive small-max-card-table">
						<!-- Projects table -->
						<table class="table align-items-center table-flush">
							<thead class="thead-light">
								<tr>
									<th scope="col" style="width: 15%;">Order Id</th>
									<th scope="col" style="width: 15%;">Total Amount</th>
									<th scope="col" style="width: 70%;">Products</th>
								</tr>
							</thead>
							<tbody>
								@forelse ($orders as $order)
									<tr>
										<th scope="row">
											{{ $order->id }}
										</th>
										<td>
											{{ $order->total_amount }}
										</td>
										<td>
											@foreach ($order->products as $index => $product)
												@if ($index > 0)
													,&nbsp;{{-- Add space after each comma --}}
												@endif
												{{ $product->title }}
												<i class="fas fa-info-circle" data-toggle="tooltip" data-placement="top" title="{{ $product->title }} - Amount: {{ $product->amount }}, Quantity: {{ $product->quantity }}"></i>
											@endforeach
										</td>
									</tr>
								@empty
									<tr>
										<td colspan="3">No orders found</td>
									</tr>
								@endforelse
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-xl-4 order-xl-1">
				<?php if($page->image): ?>
				<div class="card">
					<div class="card-body">
						<img src="<?php echo url($page->image) ?>">
					</div>
				</div>
				<?php endif; ?>
				<div class="card">
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col">
								<h3 class="mb-0">This Month Visits</h3>
							</div>
							<div class="col text-right">
								<a href="#!" class="btn btn-sm py-2 px-3 btn-primary">See all</a>
							</div>
						</div>
					</div>
					<div class="table-responsive small-max-card-table">
						<!-- Projects table -->
						<table class="table align-items-center table-flush">
							<thead class="thead-light">
								<tr>
									<th scope="col">Date</th>
									<th scope="col">Visitors</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">
										05-01-2021
									</th>
									<td>
										340
									</td>
								</tr>
								<tr>
									<th scope="row">
										05-01-2021
									</th>
									<td>
										340
									</td>
								</tr>
								<tr>
									<th scope="row">
										05-01-2021
									</th>
									<td>
										340
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
								<h3 class="mb-0">Other Information</h3>
							</div>
						</div>
					</div>
					<div class="table-responsive">
						<!-- Projects table -->
						<table class="table align-items-center table-flush">
							<tbody>
								<tr>
									<th scope="row">
										Status
									</th>
									<td>
										<?php echo $page->status ? '<span class="badge badge-success">Published</span>' : '<span class="badge badge-danger">Unpublished</span>' ?>
									</td>
								</tr>
								<tr>
									<th scope="row">
										Created By
									</th>
									<td>
										<?php echo isset($page->owner) ? $page->owner->first_name . ' ' . $page->owner->last_name : "-" ?>
									</td>
								</tr>
								<tr>
									<th scope="row">
										Created On
									</th>
									<td>
										<?php echo _dt($page->created) ?>
									</td>
								</tr>
								<tr>
									<th scope="row">
										Last Modified
									</th>
									<td>
										<?php echo _dt($page->modified) ?>
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