# -*- coding: utf-8 -*-
# Generated by Django 1.9.4 on 2016-04-10 22:51
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('game', '0015_seedkeyval_ordering'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='seedkeyval',
            options={'ordering': ('ordering',)},
        ),
        migrations.AlterField(
            model_name='seedkeyval',
            name='val',
            field=models.CharField(default='', max_length=5000),
        ),
    ]