var gulp = require('gulp');
var less = require('gulp-less');
var prefix = require('gulp-autoprefixer');
var connect = require('gulp-connect');
var rename = require('gulp-rename');
var imageop = require('gulp-image-optimization');
var clean = require('gulp-clean');
var asciify = require('asciify');
var sourcemaps = require('gulp-sourcemaps');
var gutil = require('gulp-util');
var cleanCSS = require('gulp-clean-css');

var serverPort = 8085;

// dirs prefix
var sourcesRoot = 'src/';
var develRoot = '_devel/';
var distRoot = '_dist/';


var workingRoot = develRoot;

var releasing = false;

// files configuration
var FILES = {
	lessToStart: sourcesRoot + 'css/fnx_ui.less',
	lessDemo: sourcesRoot + 'css/demo.less',
	lessThemes: sourcesRoot + 'css/theme_*.less',
	lessToWatch: sourcesRoot + 'css/**/*.less',
	images: sourcesRoot + 'img/**',
	html: sourcesRoot + '*.html',
	copy: [
		sourcesRoot + '**/*.woff',
		sourcesRoot + '**/*.ttf'
	]
};


// Devel tasks
gulp.task('server', function() {
	connect.server({
		livereload: true,
		root: [workingRoot],
		port: serverPort
	});
});

function buildCss(files) {
	gulp.src(files)
		//.pipe(sourcemaps.init())
		.pipe(less().on('error', function(err){
			gutil.log(err);
			this.emit('end');
		}))
		.pipe(cleanCSS({compatibility: 'ie11'})) //, 'aggressiveMerging':false, 'restructuring': false}))
		//.pipe(sourcemaps.write())
		.pipe(gulp.dest(workingRoot + 'css'))
		.pipe(connect.reload());
}

gulp.task('less', function () {
	buildCss(FILES.lessToStart);
});

gulp.task('less-themes', function () {
	buildCss(FILES.lessThemes);
});

gulp.task('less-demo', function () {
	buildCss(FILES.lessDemo);
});

gulp.task('images', function() {
	if (releasing) {
		gulp.src(FILES.images)
			.pipe(imageop({
				optimizationLevel: 5,
				progressive: true,
				interlaced: true
			}))
			.pipe(gulp.dest(workingRoot + 'img'));
	} else {
		gulp.src(FILES.images)
			.pipe(gulp.dest(workingRoot + 'img'))
			.pipe(connect.reload());
	}
});

gulp.task('html', function(){
	gulp.src(FILES.html, { base: '' })
		.pipe(gulp.dest(workingRoot)).pipe(connect.reload())
	;
});

gulp.task('copy', function(){
	gulp.src(FILES.copy, { base: '' })
		.pipe(gulp.dest(workingRoot)).pipe(connect.reload())
	;
});

// watch for dev server
gulp.task('watch', function () {
	gulp.watch(FILES.lessToWatch, ['less']);
	gulp.watch(FILES.images, ['images']);
	gulp.watch(FILES.html, ['html']);
	gulp.watch(FILES.copy, ['copy']);
});

gulp.task('devel', ['server', 'less', 'less-themes', 'less-demo', 'images', 'html', 'copy', 'watch'], function() {
	asciify('Watching changes', {color:'yellow', font: 'smshadow'}, function(err, res){ console.log(res); });
});

gulp.task('configure-release', function() {
	workingRoot = distRoot;
	releasing = true;
});

gulp.task('release', ['configure-release', 'less', 'less-themes', 'less-demo', 'images', 'copy', 'html'], function() {
	asciify('Releasing', {color:'yellow', font: 'smshadow'}, function(err, res){ console.log(res); });
});

gulp.task('default', function() {
	gutil.log('\n\n\n' + 'Usage: gulp ' + gutil.colors.red('<command>') + '\n'
		+ '\n' + 'Where ' + gutil.colors.red('<command>') + 'if one of:' + '\n'
		+ '\t ' + gutil.colors.green('devel') + ' - start server on port: ' + serverPort + ' and live reload your changes' + '\n'
		+ '\t ' + gutil.colors.green('release') + ' - builds and copies to ' + distRoot
	);
});
