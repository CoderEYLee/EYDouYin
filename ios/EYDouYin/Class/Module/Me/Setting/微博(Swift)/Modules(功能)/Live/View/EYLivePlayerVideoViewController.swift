//
//  EYLivePlayerVideoViewController.swift
//  weiboSwift
//
//  Created by gujiabin on 2017/6/22.
//  Copyright © 2017年 lieryang. All rights reserved.
//  映客直播界面

import UIKit
import IJKMediaFramework

class EYLivePlayerVideoViewController: UIViewController {

    // 直播地址
    var url:String?

    var ijkplayer: IJKFFMoviePlayerController?

    @IBAction func close() {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    @IBAction func gift(_ sender: UIButton) {
        let duration = 3.0
        let width: CGFloat = 300
        let height: CGFloat = 200
        let car = UIImageView(image: #imageLiteral(resourceName: "live_address_porsche"))
        car.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(car)

        // 跑车动画
        UIView.animate(withDuration: duration, animations: {
            car.frame =
                CGRect(x: EYScreenWidth * 0.5 - width * 0.5, y: EYScreenHeight * 0.5 - height * 0.5, width: 300, height: 200)
        }) { (_) in
            UIView.animate(withDuration: duration, animations: {
                car.alpha = 0.0
            }) { (_) in
                car.removeFromSuperview()
            }
        }

        //烟花 https://github.com/yagamis/emmitParticles  //需要一张live_address_tspark图片
        let layerFlower = CAEmitterLayer()
        view.layer.addSublayer(layerFlower)
        emmitParticles(from: CGPoint(x: 0, y: EYScreenHeight), emitter: layerFlower, in: view)

        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) {
            layerFlower.removeFromSuperlayer()
        }
    }

    @IBAction func like(_ sender: UIButton) {
        //爱心大小
        let heart = DMHeartFlyView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

        //爱心的中心位置
        heart.center = CGPoint(x: sender.frame.origin.x, y: sender.frame.origin.y)

        view.addSubview(heart)
        heart.animate(in: view)

        //爱心按钮的 大小变化动画
        let heartAnime = CAKeyframeAnimation(keyPath: "transform.scale")
        heartAnime.values   = [1.0, 0.7, 0.5, 0.3, 0.5, 0.7, 1.0, 1.2, 1.4, 1.2, 1.0]
        heartAnime.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
        heartAnime.duration = 0.2
        sender.layer.add(heartAnime, forKey: "show")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let ijplayer = ijkplayer else {
            return
        }

        if ijplayer.isPlaying() {
            return
        }

        ijplayer.prepareToPlay()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        guard let ijplayer = ijkplayer else {
            return
        }
        ijplayer.shutdown()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension EYLivePlayerVideoViewController
{
    /// 重写父类方法
    func setupUI() {

        setupPlayerView()
		
		setupControlView()
    }

    private func setupPlayerView()  {
        //初始化IJ播放器的控制器
        ijkplayer = IJKFFMoviePlayerController(contentURLString: url, with: nil)
        //设置播放界面的大小 满屏
		ijkplayer?.view.frame = EYScreenBounds

        //设置log上报打印级别 实际测试没有什么效果
        //默认为 k_IJK_LOG_DEFAULT
        IJKFFMoviePlayerController.setLogReport(false)
        IJKFFMoviePlayerController.setLogLevel(.init(k_IJK_LOG_ERROR.rawValue))

        //插入到view的最下面
        view.insertSubview(ijkplayer?.view ?? UIView(), at: 0)
    }
	private func setupControlView()  {

	}
}
