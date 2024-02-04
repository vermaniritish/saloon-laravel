<?php
use App\Models\Admin\Settings;;
$favicon = Settings::get('favicon');
$logo = Settings::get('logo');
$companyName = Settings::get('company_name');
$googleKey = Settings::get('google_api_key');
$version = 1.0;
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="Start your development with a Dashboard for Bootstrap 4.">
	<meta name="author" content="Creative Tim">
	<title><?php echo $companyName ?></title>
	<!-- Favicon -->

	<?php if($favicon): ?>
		<link rel="icon" href="<?php echo url($favicon) ?>" type="image/png">
	<?php endif; ?>
	<!-- Fonts -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
	<!-- ==== font Awesome css ==== -->
	<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.11.0/css/all.css" />
	<!-- Icons -->
	<link rel="stylesheet" href="<?php echo url('assets/vendor/nucleo/css/nucleo.css') ?>" type="text/css">
	<link rel="stylesheet" href="<?php echo url('assets/vendor/@fortawesome/fontawesome-free/css/all.min.css') ?>" type="text/css">
	<!-- Page plugins -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
	<!-- Argon CSS -->
	<!-- ==== owl carousel ==== -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css" rel="stylesheet" type="text/css" />
	<!-- ==== owl carousel ==== -->
	<!-- ==== Lightbox  ==== -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="<?php echo url('assets/css/argon.css') ?>" type="text/css">
	<?php if(strpos(request()->route()->getAction()['as'], 'admin.products.add') > -1 || strpos(request()->route()->getAction()['as'], 'admin.products.edit') > -1): ?>
	<script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=false&key=<?php echo $googleKey ?>&libraries=places&language=en-AU"></script>
	<?php endif; ?>

</head>

<body>
	<!-- Sidenav -->
	<nav class="sidenav navbar navbar-vertical  fixed-left  navbar-expand-xs navbar-light bg-white" id="sidenav-main">
		<div class="scrollbar-inner">
			<!-- Brand -->
			<div class="sidenav-header  align-items-center">
				<a class="navbar-brand" href="<?php echo route('admin.dashboard') ?>">
					<?php if($logo): ?>
						<img src="<?php echo url($logo) ?>" class="navbar-brand-img" alt="...">
					<?php else: ?>
						<h2><?php echo $companyName ?></h2>
					<?php endif; ?>
				</a>
			</div>
			<div class="navbar-inner">
					<!-- Include menu items -->
					@include('admin.partials.menu')
			</div>
		</div>
	</nav>
		<!-- Main content -->
		<div class="main-content" id="panel">
			<!-- Header -->
			@include('admin.partials.header')
			<!-- Header -->
			<!-- Content render here -->
			<section>
				@yield('content')
			</section>
			<!-- Content -->
			@include('admin.partials.footer')
		</div>
		<!-- Argon Scripts -->
		<form method="post" action="<?php echo route('admin.actions.uploadFile') ?>"  enctype="multipart/form-data" class="d-none" id="fileUploadForm">
			<?php echo csrf_field() ?>
			<input type="hidden" name="path" value="">
			<input type="hidden" name="file_type" value="">
			<input type="file" name="file">
			<input type="hidden" name="resize_large">
			<input type="hidden" name="resize_medium">
			<input type="hidden" name="resize_small">
		</form>
		
		<!-- Core -->
		<script>
			var site_url = "<?php echo url("/") ?>";
			var admin_url = "<?php echo url("/admin/") ?>";
			var current_url = "<?php echo url()->current(); ?>";
			var current_full_url = "<?php echo url()->full(); ?>";
			var previous_url = "<?php echo url()->previous(); ?>";
			var csrf_token = function(){
				return "<?php echo csrf_token() ?>";
			}
		</script>
		<script src="<?php echo url('assets/vendor/jquery/dist/jquery.min.js') ?>"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.12/jquery-ui.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="https://cdn.jsdelivr.net/npm/vue@2.6.14/dist/vue.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.3/dist/jquery.validate.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
		<script src="<?php echo url('assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js') ?>"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
		<script src="<?php echo url('assets/vendor/js-cookie/js.cookie.js') ?>"></script>
		<script src="<?php echo url('assets/vendor/jquery.scrollbar/jquery.scrollbar.min.js') ?>"></script>
		<script src="<?php echo url('assets/vendor/jquery-scroll-lock/dist/jquery-scrollLock.min.js') ?>"></script>
		<script src="<?php echo url('assets/js/bootstrap-notify.js') ?>"></script>
		<script src="<?php echo url('assets/js/jquery.form.min.js') ?>"></script>
		<script src="https://cdn.ckeditor.com/4.13.0/standard/ckeditor.js"></script> 
		<script src="<?php echo url('assets/js/ckeditor_image_plugin.js') ?>"></script>

		<script src="<?php echo url('assets/js/argon.js') ?>"></script>
		<script src="<?php echo url('assets/js/tag-it.min.js') ?>"></script>
		<script src="<?php echo url('assets/js/custom.js') ?>"></script>
		<?php 
		$action = get_controller_action(request()->route()->getAction()['controller']);
		$route = explode('/', $action);
		$controller = $route[0];
		$method = isset($route[1]) ? $route[1] : null;
		?>
		<?php if(file_exists(public_path('assets/js/' . $action. '.js'))): ?>
		<script src="<?php echo url('assets/js/' . $action. '.js?v=' . $version) ?>"></script>
		<?php elseif( (strpos($action, '/add') > -1 || strpos($action, '/edit') > -1)  && file_exists(public_path('assets/js/'.$controller.'/form.js')) ): ?>
		<script src="<?php echo url('assets/js/'.$controller.'/form.js?v=' . $version) ?>"></script>
		<?php endif; ?>
</body>
</html>
