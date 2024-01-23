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
		<?php echo $row->name. ' - ' . $row->phonenumber ?>
	</td>
	<td>
		<?php echo $row->seller ? 'Seller' : 'Customer' ?>
	</td>
	<td>
		<a href="mailto:<?php echo $row->email ?>" target="_blank"><?php echo $row->email ?></a>
	</td>
	<td>
		<?php echo isset($row->last_login) &&$row->last_login ? _dt($row->last_login) : '' ?>
	</td>
	<td>
        <div class="custom-control">
			<label class="custom-toggle">
				<?php $switchUrl =  route('admin.actions.switchUpdate', ['relation' => 'users', 'field' => 'status', 'id' => $row->id]); ?>
				<input type="checkbox" name="status" onchange="switch_action('<?php echo $switchUrl ?>', this)" value="1" <?php echo ($row->status ? 'checked' : '') ?>>
				<span class="custom-toggle-slider rounded-circle" data-label-off="OFF" data-label-on="ON"></span>
			</label>
		</div>
	</td>
	<td>
		<?php echo _dt($row->created) ?>
	</td>
	<td class="text-right">
		<?php if(Permissions::hasPermission('users', 'update') || Permissions::hasPermission('users', 'delete')): ?>
		<div class="dropdown">
			<a class="btn btn-sm btn-icon-only text-warning" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="fas fa-ellipsis-v"></i>
			</a>
			<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
				<a class="dropdown-item" href="<?php echo route('admin.users.view', ['id' => $row->id]) ?>">
					<i class="fas fa-eye text-yellow"></i>
					<span class="status">View</span>
				</a>
				<?php if(Permissions::hasPermission('users', 'update')): ?>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="<?php echo route('admin.users.edit', ['id' => $row->id]) ?>">
					<i class="fas fa-pencil-alt text-info"></i>
					<span class="status">Edit</span>
				</a>
				<?php endif; ?>
				<?php if(Permissions::hasPermission('users', 'delete')): ?>
				<div class="dropdown-divider"></div>
				<a 
					class="dropdown-item _delete" 
					href="javascript:;"
					data-link="<?php echo route('admin.users.delete', ['id' => $row->id]) ?>"
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