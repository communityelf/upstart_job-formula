{% from "template/map.jinja" import template with context %}

{% if upstart_job['jobs'] %}
{% for jobname, jobdef in upstart_job['jobs'].iteritems() %}
upstart_job {{ jobname }}:
  file.managed:
    - name: {{ path }}{{ jobname }}.conf
    - template: jinja
    - source: salt://upstart_job/files/upstart_job.jinja
    - context: {{ jobdef|json }}
  service.running:
    - name: {{ jobname }}
    - enable: True
{% endfor %}
{% endif %}
