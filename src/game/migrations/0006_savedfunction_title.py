# -*- coding: utf-8 -*-
# Generated by Django 1.9.4 on 2016-03-23 10:58
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('game', '0005_savedfunction'),
    ]

    operations = [
        migrations.AddField(
            model_name='savedfunction',
            name='title',
            field=models.CharField(blank=True, max_length=255),
        ),
    ]
