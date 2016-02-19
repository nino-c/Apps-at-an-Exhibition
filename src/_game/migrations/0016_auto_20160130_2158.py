# -*- coding: utf-8 -*-
# Generated by Django 1.9.1 on 2016-01-30 21:58
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('game', '0015_imagetest'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='gameinstancesnapshot',
            name='gallery',
        ),
        migrations.AlterField(
            model_name='gameinstancesnapshot',
            name='instance',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='images', to='game.AppInstance'),
        ),
    ]
