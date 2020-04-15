import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { Gstr01Component } from './gstr01.component';

const routes: Routes = [
  {
    path : "",
    component : Gstr01Component,
    children : [
      {
        path : "client",
        loadChildren: () => import('./gstr01-client/gstr01-client.module').then(mod => mod.Gstr01ClientModule)
      },
      {
        path : "dashboard",
        loadChildren: () => import('./gstr01-dashboard/gstr01-dashboard.module').then(mod => mod.Gstr01DashboardModule)
      },
      {
        path : "fillform",
        loadChildren: () => import('./gstr01-fillform/gstr01-fillform.module').then(mod => mod.Gstr01FillformModule)
      },
      {
        path: 'receiver',
        loadChildren: () => import('node_modules/genmaster/src/master/return-seller/return-seller.module').then(mod => mod.ReturnSellerModule),
      },
      {
        path : "summary",
        loadChildren: () => import('./gstr01-summary/gstr01-summary.module').then(mod => mod.Gstr01SummaryModule)
      },
      {
        path : "reconciliation",
        loadChildren: () => import('./gstr01-reconciliation/gstr01-reconciliation.module').then(mod => mod.Gstr01ReconciliationModule)
      },
      {
        path : "sms",
        loadChildren: () => import('../sms/sms.module').then(mod => mod.SmsModule) 
      },
      {
        path : "email",
        loadChildren: () => import('../email/email.module').then(mod => mod.EmailModule) 
      },
      {
        path : "configuration",
        loadChildren: () => import('../configuration/configuration.module').then(mod => mod.ConfigurationModule) 
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class Gstr01RoutingModule { }
