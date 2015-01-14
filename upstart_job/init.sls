{% from "upstart_job/map.jinja" import upstart_job with context %}

{% if upstart_job['jobs'] %}
{% for jobname, jobdef in upstart_job['jobs'].iteritems() %}
upstart_job {{ jobname }}:
  file.managed:
    - name: {{ upstart_job['path'] }}{{ jobname }}.conf
    - template: jinja
    - source: salt://upstart_job/files/upstart_job.jinja
    - context: {{ jobdef|json }}
  service.running:
    - name: {{ jobname }}
    - enable: True
{% endfor %}
{% endif %}
