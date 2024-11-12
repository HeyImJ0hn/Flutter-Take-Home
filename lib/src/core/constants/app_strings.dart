class AppStrings {

  static const String appName = 'Flutter Take Home';

  // Routes
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String postDetailsRoute = '/post/';
  static const String postDetailsRouteParam = 'id';

  // Auth
  static const String loginTitle = 'Welcome,';
  static const String loginSubtitle = 'Please login to continue';
  static const String loginUsername = 'Username';
  static const String loginPassword = 'Password';
  static const String loginButtonText = 'Login';
  static const String loginValidationFail = 'Please fill in all fields';
  static const String loginFormEmptyField = 'This field cannot be empty';

  // Dashboard
  static const String dashboardTitle = 'Dashboard';
  static const String dashboardLogoutButtonText = 'Logout';
  static const String commentCountPlaceholder = '...';
  static const String commentCountFailure = 'Failed to load comments';
  static const String noPostsAvailable = 'No posts available';

  // Post Details
  static const String postDetailsTitle = 'Post Details';
  static const String postDetailsCommentsTitle = 'Comments';
  static const String postDetailsNoComments = 'No comments available';
  static const String postDetailsNoPost = 'No post available';

  // Posts Bloc
  static const String postsBlocFailure = 'Failed to fetch posts';

  // Post Bloc
  static const String postBlocFailure = 'Failed to fetch post';

  // Details Bloc
  static const String detailsBlocFailure = 'Failed to fetch comments';

  // Dash Data Source
  static const String dashDataSourcePostsFailure = 'Failed to fetch posts';
  static const String dashDataSourcePostFailure = 'Failed to fetch post';
  static const String dashDataSourceCommentsFailure = 'Failed to fetch comments for post';

  // Auth Bloc
  static const String authBlocLoginFailure = 'Authentication Failed';
  static const String authBlocLogoutFailure = 'Logout Failed';
  static const String authBlocCheckAuthenticationFailure = '';

  // Auth Data Source
  static const String authDataSourceAuthenticationFailure = 'User is not authenticated.';
  static const String authDataSourceAuthenticationError = 'Error checking if user is authenticated.';
  static const String authDataSourceLoginError = 'Error logging in.';
  static const String authDataSourceLogoutError = 'Error logging out.';
}