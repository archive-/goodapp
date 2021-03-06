module VtGetReportJob
  @queue = :main

  def self.perform(opts={})
    app = App.find(opts["app_id"])
    url = "https://www.virustotal.com/vtapi/v2/file/report"
    json = RestClient.post(url, apikey: Settings.vtapi_key, resource: app.vtsha256)
    res = JSON.parse(json)
    if res["response_code"] == 1
      app.vtpos = res["positives"].to_i
      app.vttotal = res["total"].to_i
      vtrating = 1.0 - (app.vtpos ** 2).to_f / app.vttotal
      vtrating = vtrating > 0.0 ? vtrating : 0.0
      if app.vtrating != vtrating
        Endorsement.queue_resync
        app.vtrating = vtrating
      end
      app.progress(100)
    else
      # TODO back off a bit and try again later (every 20 minutes)?
      Resque.enqueue_at_with_queue(:main, 10.minutes.from_now, VtGetReportJob, app_id: app.id)
    end
  end
end
