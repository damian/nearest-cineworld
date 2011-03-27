module PerformancesHelper

  def list_performances(performances, today = true)
    unless today
      return performances.map do |performance|
        link_to performance.booking_url do
          content_tag(:span, performance.time, :class => 'performance available')
        end
      end.join(' ').html_safe
    end
    now = Time.now
    performances.map do |performance|
      hours, mins = performance.time.split(':')
      ptime = Time.utc(now.year, now.month, now.day, hours, mins, 0)
      link_to performance.booking_url do
        content_tag(:span, performance.time, :class => ptime > now ? 'performance available' : 'performance unavailable')
      end
    end.join(' ').html_safe
  end
end
