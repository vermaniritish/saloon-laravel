@extends('layouts.adminlayout')
@section('content')
<?php
	use App\Models\Admin\Settings;
	$currency = Settings::get('currency_symbol'); 
?>
	<div class="header bg-primary pb-6">
		<div class="container-fluid">
			<div class="header-body">
				<div class="row align-items-center py-4">
					<div class="col-lg-6 col-7">
						<h6 class="h2 text-white d-inline-block mb-0">Manage Staff</h6>
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
	<div id="staff">
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
						<div class="card-body">
							<form action="<?php echo route('admin.staff.view',['id' => $page->id]) ?>" method="GET" id="filters-form">
								<div class="row">
									<div class="col-md-4">
										<div class="form-group">
											<label class="form-control-label" for="fromDate">From Date:</label>
											<input type="date" class="form-control" name="order_created[0]" value="{{ isset($_GET['order_created'][0]) ? $_GET['order_created'][0] : '' }}" placeholder="DD-MM-YYYY" >
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label class="form-control-label" for="toDate">To Date:</label>
											<input type="date" class="form-control" name="order_created[1]" id="toDate" value="{{ isset($_GET['order_created'][1]) ? $_GET['order_created'][1] : '' }}" placeholder="DD-MM-YYYY" >
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label> </label>
											<button type="submit" class="btn btn-primary mt-4"><i class="fas fa-filter"></i> Filter</button>
										</div>
									</div>
								</div>
							</form>
							<div class="table-responsive small-max-card-table">
								<!-- Projects table -->
								<table class="table align-items-center table-flush">
									<thead class="thead-light">
										<tr>
											<th scope="col" style="width: 15%;">Order Id</th>
											<th scope="col" style="width: 35%;">Products</th>
											<th scope="col" style="width: 15%;">Status</th>
											<th scope="col" style="width: 20%;">Created</th>
											<th scope="col" style="width: 15%;">Total Amount</th>
										</tr>
									</thead>
									<tbody>
										@forelse ($orders as $order)
											<tr>
												<th scope="row">
													<a href="<?php echo route('admin.orders.view', ['id' => $order->id]) ?>"><?php echo $order->id; ?></a>
												</th>
												<td>
												@foreach ($order->products as $index => $product)
													{{ $product->title }}
													<i title="Amount: {{$currency}} {{ $product->amount }}, Quantity: {{ $product->quantity }}">
														| Amount: {{$currency}} {{ $product->amount }} | Quantity: {{ $product->quantity }}
													</i>

													{{-- Add a line break after each product except the last one --}}
													@if (!$loop->last)
														<br>
													@endif
												@endforeach
												</td>
												<td>
													<?php $statusData = $status[$order->status] ?? null; ?>
													<?php if ($statusData): ?>
														<button class="btn btn-sm" style="<?php echo $statusData['styles']; ?>"
																type="button" id="statusDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
																data-toggle="tooltip" title="{{ $order->statusBy ? ($order->statusBy->first_name . ($order->statusBy->last_name ? ' ' . $order->statusBy->last_name : '')) : null }}">
															{{ $statusData['label'] }}
														</button>
													<?php endif; ?>
												</td>
												<td>
													{{ _dt($order->created) }}
												</td>
												<td style="font-size: 16px; font-weight: bold;">
													{{$currency}} {{$order->total_amount }}
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
						<!--!! FLAST MESSAGES !!-->
						@include('admin.partials.flash_messages')
						<div class="card-header">
							<div class="row align-items-center">
								<div class="col-md-6">
									<h3 class="mb-0">Uploaded Documents</h3>
								</div>
								<div class="col-md-6">
									<div class="button-ref mb-3">
										<button type="button" class="btn btn-primary btn-sm float-lg-right mt-2" data-toggle="modal" data-target="#uploadModal">
										<i class="fas fa-plus"></i>
											Add new
										</button>
									</div>
								</div>
							</div>
						</div>
						<div class="table-responsive">
							<table class="table align-items-center table-flush listing-table">
								<thead class="thead-light">
									<tr>
										<th class="checkbox-th">
											<div class="custom-control custom-checkbox">
												<input type="checkbox" class="custom-control-input mark_all"
													id="mark_all">
												<label class="custom-control-label" for="mark_all"></label>
											</div>
										</th>
										<th class="sort" width="5%">
										</th>
										<th class="sort" width="65%">Documents <i class="fas fa-sort"
												data-field="resourcesDocuments.title"></i>
										</th>
										<th width="5%">
											Actions
										</th>
									</tr>
								</thead>
								<tbody class="list">
									@php
										$filePaths = json_decode($page->file);
									@endphp
									@if ($filePaths && is_array($filePaths))
										@foreach ($filePaths as $index => $filePath)
											@php
												$fileName = pathinfo($filePath, PATHINFO_BASENAME);
											@endphp
											<tr>
												<td>
													<div class="custom-control custom-checkbox">
														<input type="checkbox"
															class="custom-control-input listing_check"
															id="listing_check189" value="189">
														<label class="custom-control-label"
															for="listing_check189"></label>
													</div>
												</td>
												<td style="cursor:pointer;">
													<a href={{ url('/admin/ncr/' . ($filePath ? $filePath . '/' : '') . $page->id) }}
														target="_blank"><i class="fa fa-file-alt"
															style="font-size: 40px"></i>
													</a>
												</td>
												<td style="cursor:pointer;">
													<a href={{ url($filePath) }}
														target="_blank">{{ $fileName }}<br><small>{{ $filePath }}</small></a>
												</td>
												<td class="text-right">
													<?php if(Permissions::hasPermission('staff', 'delete')): ?>                                                        <a 
														class="dropdown-item _delete" 
														href="javascript:;"
														data-link="<?php echo route('admin.ncr.documentDelete', ['id' => $page->id, 'index' => $index]) ?>"
													>
														<i class="fas fa-times text-danger"></i>
														<span class="status text-danger">Delete</span>
													</a>
												<?php endif; ?>
												
												</td>
											</tr>
										@endforeach
									@else
										<tr>
											<td colspan="4">No documents available</td>
										</tr>
									@endif
								</tbody>
								<tfoot>
									<tr>
										<th align="left" colspan="20">
											<div class="ajaxPaginationEnabled loader text-center hidden"
												data-url="http://127.0.0.1:8002/admin/resources-documents/65/133"
												data-page="1" data-counter="40" data-total="2">
												<div class="preloader pl-size-xs">
													<div class="spinner-layer pl-indigo">
														<div class="circle-clipper left">
															<div class="circle"></div>
														</div>
														<div class="circle-clipper right">
															<div class="circle"></div>
														</div>
													</div>
												</div>
											</div>
										</th>
									</tr>
								</tfoot>
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
		<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" aria-labelledby="uploadModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="uploadModalLabel">Add New Documents</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body pt-0">
						<form method="post" id="saveDoc" class="form-validation" enctype="multipart/form-data">
							{{ @csrf_field() }}
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label class="form-control-label" for="input-username">Document Title</label>
										<input type="text" class="form-control" name="title" required
										placeholder="Enter your answer" v-model="title" autofocus>
										@error('title')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
									<hr class="my-4">
									<div class="upload-image-section" data-type="file" data-multiple="true"
										data-path="staff-documents">
										<div class="upload-section">
											<div class="button-ref mb-3">
												<button class="btn btn-icon btn-primary btn-lg" type="button">
													<span class="btn-inner--icon"><i class="fas fa-upload"></i></span>
													<span class="btn-inner--text">Upload Documents</span>
												</button>
											</div>
											<!-- PROGRESS BAR -->
											<div class="progress d-none">
												<div class="progress-bar bg-default" role="progressbar"
													aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"
													style="width: 0%;"></div>
											</div>
										</div>
										<!-- INPUT WITH FILE URL -->
										<textarea class="d-none" id="docFile" name="file"><?php echo old('file'); ?></textarea>
										<div class="show-section <?php echo !old('file') ? 'd-none' : ''; ?>">
											@include('admin.partials.previewFileRender', [
												'file' => old('file'),
											])
										</div>
									</div>
								</div>
							</div>
							<hr class="my-4">
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
								<a href="javascript:;" class="btn btn-primary float-right" v-on:click="saveDocumentInfo({{ $page->id }})">
									<i class="fa fa-spin fa-spinner" v-if="loading"></i>
									<i v-else class="fa fa-save"></i> Save
								</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
@endsection