class AppDelegate
  DISCOVER_URL = "http://busme-apis.herokuapp.com/apis/d1/get"
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'problem-arp'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    @queue = Dispatch::Queue.new("background")



    @discoverApi    = IPhone::DiscoverApi.new(nil, DISCOVER_URL)

    @queue.async do
      @discoverApi.get
    end
    @queue.async do
      @discoverApi.discover(-76.43, 43, 1000)
    end
    true
  end
end
