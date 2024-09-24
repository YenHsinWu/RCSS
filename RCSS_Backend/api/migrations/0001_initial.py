# Generated by Django 5.1 on 2024-09-16 06:29

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='AppSettings',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False)),
                ('setting_name', models.CharField(max_length=255)),
                ('setting_value', models.TextField()),
                ('setting_type', models.CharField(max_length=50)),
                ('description', models.TextField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('is_active', models.BooleanField()),
                ('options', models.TextField()),
                ('priority', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='AuditLog',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False)),
                ('audit_logs', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='ContentManagement',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False)),
                ('content', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='FileManagement',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False)),
                ('files', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='NetworkBasesSettings',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False)),
                ('api_base_url', models.CharField(max_length=255)),
                ('api_key', models.CharField(max_length=255)),
                ('service_port', models.IntegerField()),
                ('retry_policy', models.CharField(max_length=50)),
                ('max_connections', models.IntegerField()),
                ('security_config', models.TextField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
        ),
        migrations.CreateModel(
            name='NetworkServiceSettings',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False)),
                ('setting_name', models.CharField(max_length=255)),
                ('setting_value', models.TextField()),
                ('setting_type', models.CharField(max_length=50)),
                ('description', models.TextField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('is_active', models.BooleanField()),
                ('priority', models.IntegerField()),
                ('access_control', models.CharField(max_length=255)),
            ],
        ),
        migrations.CreateModel(
            name='NotificationLog',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False)),
                ('notifications', models.TextField()),
                ('logs', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='ReportingAnalysis',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False)),
                ('reports_type', models.CharField(max_length=255)),
                ('reports_settings', models.JSONField()),
            ],
        ),
    ]
