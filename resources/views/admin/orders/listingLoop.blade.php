<?php foreach($listing->items() as $k => $row): ?>
<tr>
	<td>
		<!-- MAKE SURE THIS HAS ID CORRECT AND VALUES CORRENCT. THIS WILL EFFECT ON BULK CRUTIAL ACTIONS -->
		<div class="custom-control custom-checkbox">
			<input type="checkbox" class="custom-control-input listing_check" id="listing_check<?php echo $row->id ?>" value="<?php echo $row->id ?>">
			<label class="custom-control-label" for="listing_check<?php echo $row->id ?>"></label>
		</div>
	</td>
	<td>
		<span class="badge badge-dot mr-4">
			<i class="bg-warning"></i>
			<span class="status"><?php echo $row->id ?></span>
		</span>
	</td>
	<td>
		<?php echo $row->customer_name ?>
	</td>
	<td>
		<?php echo _d($row->booking_date) ?>
	</td>
	<td>
		<?php echo $row->address ?>
	</td>
	<td>
		<?php echo $row->total_amount ?>
	</td>
	<td>
		<?php echo _dt($row->created) ?>
	</td>
	<td class="text-right">
	<?php if(Permissions::hasPermission('orders', 'update') || Permissions::hasPermission('orders', 'delete')): ?>
		<div class="dropdown">
			<a class="btn btn-sm btn-icon-only text-warning" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-ellipsis-v"></i>
			</a>
			<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
				<a class="dropdown-item" href="<?php echo route('admin.orders.view', ['id' => $row->id]) ?>">
					<i class="fas fa-eye text-yellow"></i>
					<span class="status">View</span>
				</a>
				<?php if(Permissions::hasPermission('orders', 'update')): ?>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="<?php echo route('admin.orders.edit', ['id' => $row->id]) ?>">
						<i class="fas fa-pencil-alt text-info"></i>
						<span class="status">Edit</span>
					</a>
				<?php endif; ?>
				<?php if(Permissions::hasPermission('orders', 'delete')): ?>
					<div class="dropdown-divider"></div>
					<a 
						class="dropdown-item _delete" 
						href="javascript:;"
						data-link="<?php echo route('admin.orders.delete', ['id' => $row->id]) ?>"
					>
						<i class="fas fa-times text-danger"></i>
						<span class="status text-danger">Delete</span>
					</a>
				<?php endif; ?>
			</div>
		</div>
	<?php endif; ?>
	</td>
</tr>
<?php endforeach; ?>