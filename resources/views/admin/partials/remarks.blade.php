<?php 
use App\Libraries\FileSystem; 
use App\Models\Admin\AdminAuth; 
$loginId = AdminAuth::getLoginId();
?>
<?php foreach ($listing->items() as $key => $value): 
   $image = FileSystem::getAllSizeImages($value->owner_image);
?>
<div class="d-flex comment" data-id="<?php echo $value->id ?>">
   <img class="rounded-circle comment-img"
        src="<?php echo $image && $image['small'] ? url($image['small']) : 'https://placehold.jp/30/dd6699/ffffff/64x64.png?text=' . substr($value->owner_first_name, 0 , 1) ?>" />
   <div class="flex-grow-1 ml-2">
      <div class="mb-2">
         <a class="fw-bold link-dark me-1"><?php echo $value->owner_first_name . ' ' . $value->owner_last_name ?></a> 
         <?php if(Permissions::hasPermission('remarks', 'update') || Permissions::hasPermission('remarks', 'delete') || $value->admin_id == $loginId): ?>
         <div class="dropdown float-right">
            <a class="text-primary no-btn" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
               <i class="fas fa-ellipsis-v"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                  <?php if((Permissions::hasPermission('remarks', 'update') || $value->admin_id == $loginId)): ?>
                  <a 
                     class="dropdown-item remarks-edit"
                     data-id="<?php echo $value->id ?>"
                     data-category="<?php echo $value->category ?>"
                     data-category="<?php echo $value->date_time ? _dt($value->date_time) : '' ?>"
                     href="javascript:;"
                  >
                     <i class="fas fa-pencil-alt text-info"></i>
                     <span class="status ">Edit</span>
                  </a>
                  <?php endif; ?>
                  <?php if((Permissions::hasPermission('remarks', 'update') || $value->admin_id == $loginId) && (Permissions::hasPermission('remarks', 'delete') || $value->admin_id == $loginId)): ?>
                  <div class="dropdown-divider"></div>
                  <?php endif; ?>
                  <?php if((Permissions::hasPermission('remarks', 'delete') || $value->admin_id == $loginId)): ?>
                  <a 
                     class="dropdown-item remarks-delete"
                     data-id="<?php echo $value->id ?>"
                     href="javascript:;"
                  >
                     <i class="fas fa-times text-danger"></i>
                     <span class="status text-danger">Delete</span>
                  </a>
                  <?php endif; ?>
            </div>
         </div>
         <?php endif; ?>
         <span class="badge bg-info float-right"><?php echo str_replace('-', ' ', $value->category) ?></span>
      </div>
      <div class="mb-2 c-tex">
         @if($value->date_time)
         <h5 class="text-primary">{{ _dt($value->date_time) }}</h5>
         @endif
         <?php echo General::autoLink($value->comment) ?>
      </div>
      <a class="fw-bold d-flex align-items-end float-right">
         <i class="zmdi zmdi-chevron-down fs-4 me-3"></i>
         <span class="text-muted text-nowrap"><?php echo _dt($value->created) ?></span>
      </a>
   </div>
</div>
<?php endforeach; ?>